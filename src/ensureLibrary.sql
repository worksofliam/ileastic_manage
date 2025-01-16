create or replace procedure ileastic.ensureLibrary()
  program type sub modifies sql data
  set option usrprf = *user, dynusrprf = *user, commit = *none
begin

  declare hasLibrary int default 0;

  select count(*) into hasLibrary
  from qsys2.library_list_info
  where system_schema_name = 'ILEASTIC';

  if hasLibrary = 0 then
    call qsys2.qcmdexc('ADDLIBLE ILEASTIC');
  end if;
end;