{% set configs = [
    {
        "table": "AIRBNB.GOLD.OBT",
        "columns": "obt.BOOKING_ID, obt.LISTING_ID, obt.HOST_ID, obt.TOTAL_AMOUNT, obt.CLEANING_FEE, obt.SERVICE_FEE, obt.ACCOMMODATES, obt.BEDROOMS, obt.BATHROOMS, obt.PRICE_PER_NIGHT, obt.RESPONSE_RATE",
        "alias": "obt"
    },
    {
        "table": "AIRBNB.GOLD.DIM_LISTINGS",
        "columns": "",
        "alias": "dim_listings",
        "join_condition": "obt.listing_id = dim_listings.listing_id"
    },
    {
        "table": "AIRBNB.GOLD.DIM_HOSTS",
        "columns": "",
        "alias": "dim_hosts",
        "join_condition": "obt.host_id = dim_hosts.host_id"
    }
]%}

select {{ configs[0]["columns"] }}
from
{% for config in configs %}
        {% if loop.first %} {{ config["table"] }} as {{ config["alias"] }}
    {% else %}
        left join
            {{ config["table"] }} as {{ config["alias"] }}
            on {{ config["join_condition"] }}
    {% endif %}
{% endfor %}
