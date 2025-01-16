create or replace view ileastic.services as
  select 
    job_name, 
    job_name_short, 
    subsystem, 
    authorization_name, 
    run_priority, 
    thread_count, 
    temporary_storage, 
    total_disk_io_count, 
    elapsed_time 
  from table(qsys2.active_job_info()) x 
  where 
    x.thread_count > 1 and 
    x.job_user not like 'Q%' and 
    x.job_type = 'BCH' and 
    x.function_type = 'PGM' and 
    x.function not like 'Q%' and
    (select count(*) from table(qsys2.stack_info(job_name)) where procedure_name = 'il_listen') = 1;