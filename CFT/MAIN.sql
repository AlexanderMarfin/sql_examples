declare prof_id varchar(30);
        cft2rs_id varchar(30);
        con_id_temp varchar(30);
        p varchar(30);
        err_msg varchar(200);
begin
begin
  select row_id
    into prof_id
    from siebel.s_cif_ext_syst
    where system_num = '99995';
    
exception
  when others then
    prof_id := 'PROFILE_NOTFOUND';
end;
begin
  select row_id
    into cft2rs_id
    from siebel.s_cif_ext_syst
    where system_num = 'CFT2RS';
exception
  when others then
    cft2rs_id := 'CFT2RS_NOTFOUND';
end;
commit;
con_id_temp := '';
if (prof_id <> 'PROFILE_NOTFOUND' and cft2rs_id <> 'CFT2RS_NOTFOUND') then
  for rec in (select *
          from siebel.TempCFT) loop
   begin
   begin
      select con_id into con_id_temp from siebel.s_cif_con_map
      where cif_ext_syst_id = prof_id and ext_cust_id1 = rec.ID_M3_PROFILE;
      exception
      when others then 
      update siebel.TempCFT set msg = 'Отсутствует кросс-ссылка на Profile' where ID_M3_PROFILE = rec.ID_M3_PROFILE;
    end;
      
      if con_id_temp is not null then
        begin
          select count(1) into p from siebel.s_cif_con_map
          where cif_ext_syst_id = cft2rs_id and ext_cust_id1 = rec.ID_M3_CFT2RS;
          if p = 0 then
            begin
              insert into siebel.s_cif_con_map (row_id, created_by, last_upd_by, cif_ext_syst_id, con_id, db_last_upd, db_last_upd_src, ext_cust_id1, CREATED, LAST_UPD) values
              (siebel.s_sequence_pkg.get_next_rowid, '0-1', '0-1', cft2rs_id, con_id_temp, sysdate-1/8, 'BR-21163', rec.ID_M3_CFT2RS, sysdate-1/8, sysdate-1/8);    
              commit;
              exception
              when others then
                begin
                  err_msg := sqlcode || ':' || substr(sqlerrm, 1, 200);
                  insert into siebel.cx_mdm_cft_log (mdmid, cftid, error_msg) 
                    values (rec.ID_M3_PROFILE, rec.ID_M3_CFT2RS, err_msg);
                end;
            end;
          else begin
		update siebel.TempCFT set msg1 = 'Клиент уже есть в CFT2RS' where ID_M3_CFT2RS = rec.ID_M3_CFT2RS;
              	commit;	
            end;
          end if;
        end;
          commit;
      end if;
      con_id_temp := '';
    end;
  end loop;
end if;
end;
/