with 

source as (

    select * from {{ source('raw', 'ship') }}

),

renamed as (

    select
        orders_id,
        shipping_fee, #une seule colonne gardée car doublon avec shipping_fee_1
        logcost,
        cast(ship_cost as FLOAT64) as ship_cost #CAST

    from source

)

select * from renamed
