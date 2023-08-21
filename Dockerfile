FROM python:3.10.1

RUN apt update \
    && apt install libpq-dev \
    gcc \
    wait-for-it \
    python3-pip \
    libldap2-dev \
    libsasl2-dev -y \
    && pip install --upgrade pip


WORKDIR /odoo

# Copy
COPY ./requirements.txt /odoo/requirements.txt
RUN pip install -r /odoo/requirements.txt
COPY . /odoo/

ENTRYPOINT ["/bin/bash", "-c"]
CMD ["wait-for-it -h odoo_db -p 5432 --strict --timeout=300 -- \
      /odoo/odoo-bin --config /odoo/odoo.ini"]
