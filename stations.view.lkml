view: stations {
sql_table_name: `bigquery-public-data.noaa_gsod.stations` ;;


dimension: primary_key {
  hidden: yes
  primary_key: yes
  sql: CONCAT(${usaf},${wban}) ;;
}

dimension: usaf {
  type: string
  sql: ${TABLE}.usaf ;;
}

dimension: wban {
  type: string
  sql: ${TABLE}.wban ;;
}

dimension: name {
  type: string
  sql: ${TABLE}.name ;;
}

dimension: country {
  type: string
  sql: ${TABLE}.country ;;
  map_layer_name: countries
}

dimension: state {
  type: string
  sql: ${TABLE}.state ;;
  map_layer_name: us_states
}

dimension: call {
  type: string
  sql: ${TABLE}.call ;;
}

dimension: lat {
  hidden: yes
  type: number
  sql: ${TABLE}.lat ;;
}

dimension: lon {
  hidden: yes
  type: number
  sql: ${TABLE}.lon ;;
}

dimension: location {
  type: location
  sql_latitude: ${lat} ;;
  sql_longitude: ${lon} ;;
}

dimension: elev {
  description: "Elevation (ft)"
  type: number
  sql: CAST(${TABLE}.elev as FLOAT64)* 3.2808399 ;;
  value_format_name: decimal_1
}

measure: avg_elevation {
  type: average
  sql: ${elev};;
  value_format_name: decimal_1
  }


dimension: begin {
  type: string
  sql: ${TABLE}.begin ;;
}

dimension: end {
  type: string
  sql: ${TABLE}.`end` ;;
}

  measure: count {
    type: count
    drill_fields: [name, call, country, state, elev]
  }
}
