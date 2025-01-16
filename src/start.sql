create or replace procedure ileastic.start(IN library char(10), IN objectName char(10), IN restartService char(1) default 'N', customJobName char(10) default '')
  program type sub modifies sql data
  set option usrprf = *user, dynusrprf = *user, commit = *none
begin

  declare existingJobName CHAR(28) default '';

  call ileastic.ensureLibrary();

  set library = upper(library);
  set objectName = upper(objectName);
  set restartService = upper(restartService);

  if (customJobName = '') then
    set customJobName = objectName;
  end if;

  select job_name into existingJobName
  from ileastic.services x
  where x.job_name_short = customJobName;

  if existingJobName != '' then
    if restartService = 'Y' then
      call ileastic.stop(customJobName);
    else
      signal sqlstate '38000' set message_text = 'ILEastic service already running';
      return;
    end if;
  end if;

  -- SBMJOB CMD(CALL PGM(HELLOWORLD)) JOB(HELLOWORLD) JOBQ(QSYSNOMAX) ALWMLTTH(*YES)
  call qsys2.qcmdexc('SBMJOB CMD(CALL PGM(' || rtrim(library) || '/' || rtrim(objectName) || ')) JOB(' || rtrim(customJobName) || ') JOBQ(QSYSNOMAX) ALWMLTTHD(*YES)');
end;