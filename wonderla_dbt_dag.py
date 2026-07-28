from airflow import DAG
from airflow.providers.standard.operators.bash import BashOperator
from datetime import datetime

with DAG(
    dag_id="wonderla_dbt_pipeline",
    start_date=datetime(2026, 1, 1),
    schedule="@daily",
    catchup=False,
    tags=["dbt", "wonderla"],
) as dag:

    dbt_seed = BashOperator(
        task_id="dbt_seed",
        bash_command="""
        source /home/kkulk/airflow_env/bin/activate
        cd /mnt/c/wonderla_project
        dbt seed
        """,
    )

    dbt_snapshot = BashOperator(
        task_id="dbt_snapshot",
        bash_command="""
        source /home/kkulk/airflow_env/bin/activate
        cd /mnt/c/wonderla_project
        dbt snapshot
        """,
    )

    dbt_run = BashOperator(
        task_id="dbt_run",
        bash_command="""
        source /home/kkulk/airflow_env/bin/activate
        cd /mnt/c/wonderla_project
        dbt run
        """,
    )

    dbt_test = BashOperator(
        task_id="dbt_test",
        bash_command="""
        source /home/kkulk/airflow_env/bin/activate
        cd /mnt/c/wonderla_project
        dbt test
        """,
    )

    dbt_seed >> dbt_snapshot >> dbt_run >> dbt_test

