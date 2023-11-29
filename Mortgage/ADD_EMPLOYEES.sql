MERGE INTO siebel.cx_sub_act_emp t100 USING
  (SELECT DISTINCT t6.row_id s_user_fk,
                   t3.row_id cx_lst_rel_fk
   FROM siebel.s_contact t61,
        siebel.s_user t6,
        siebel.s_party_per t5,
        siebel.s_postn t4,
        siebel.cx_lst_rel t3,
        siebel.s_lst_of_val_bu t2,
        siebel.s_org_ext t1
   WHERE t61.row_id=t6.row_id
     AND t61.emp_flg='Y' /* сотрудник */
     AND t6.row_id=t5.person_id /* сотрудник */
     AND t5.party_id=t4.row_id /* сотрудник */
     AND t4.ou_id = t1.row_id
     AND t3.par_lov_type='TODO_TYPE'
     AND t3.par_lov_name='Ipoteka'
     AND t3.lov_name='ipoteka holliday'
     AND t2.lst_of_val_id=t3.row_id
     AND t2.bu_id=t1.row_id
     AND t1.int_org_flg='Y' /* Подразделение */ ) t200 ON (t100.cx_lst_rel_fk=t200.cx_lst_rel_fk
                                                           AND t100.s_user_fk=t200.s_user_fk) WHEN NOT matched THEN
INSERT (row_id,
        created,
        created_by,
        last_upd,
        last_upd_by,
        modification_num,
        conflict_id,
        cx_lst_rel_fk,
        s_user_fk,
        db_last_upd,
        db_last_upd_src,
        TYPE)
VALUES (replace(t200.s_user_fk,'-','@'),sysdate-1/8,'0-1','0-1',0,'0',t200.cx_lst_rel_fk,t200.s_user_fk,sysdate-1/8,'BR-18523 Init',NULL) /
COMMIT /