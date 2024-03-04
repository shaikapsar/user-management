# The builder image, used to build the virtual environment
FROM python:3.11-buster as builder

RUN pip install poetry==1.2.0

ENV POETRY_NO_INTERACTION=1 \
    POETRY_VIRTUALENVS_IN_PROJECT=1 \
    POETRY_VIRTUALENVS_CREATE=1 \
    POETRY_CACHE_DIR=/tmp/poetry_cache


WORKDIR /app

COPY pyproject.toml poetry.lock ./
RUN touch README.md


RUN --mount=type=cache,target=$POETRY_CACHE_DIR poetry install --without dev --no-root



#The runtime image, used to just run the code provided its virtual environment
FROM python:3.11-slim-buster as runtime



ENV VIRTUAL_ENV=/app/.venv \
    PATH="/app/.venv/bin:$PATH"

COPY --from=builder ${VIRTUAL_ENV} ${VIRTUAL_ENV}

COPY user_management ./user_management


CMD ["uvicorn", "user_management.main:app", "--host", "0.0.0.0", "--port", "80"]