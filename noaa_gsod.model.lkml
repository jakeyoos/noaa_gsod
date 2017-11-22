connection: "bigquery"

include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project

named_value_format: temp_1 {
  value_format: "0.0\"°\""
}

# explore: gsod_aggregates {}

explore: stations {
  label: "Weather Stations"
}
explore: gsod {
  label: "Daily Weather Data"
  conditionally_filter: {
    filters: {
      field: gsod.partition_year
      value: "1 year"
    }
    }
    join: stations {
      type: left_outer
      sql_on: ${gsod.stn} = ${stations.usaf} AND ${gsod.wban} = ${stations.wban} ;;
      relationship: many_to_one
    }
}
