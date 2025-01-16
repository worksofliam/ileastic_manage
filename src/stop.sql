create or replace procedure ileastic.stop(IN short_job_name char(10))
  program type sub modifies sql data
  set option usrprf = *user, dynusrprf = *user, commit = *none
begin
  declare job_name CHAR(28) default '';

  call ileastic.ensureLibrary();

  set short_job_name = upper(short_job_name);

  select job_name into job_name
  from ileastic.services x
  where x.job_name_short = short_job_name;

  if job_name = '' then
    signal sqlstate '38000' set message_text = 'ILEastic service not found';
    return;
  end if;

  call qsys2.qcmdexc('ENDJOB JOB(' || job_name || ') OPTION(*IMMED)');
end;