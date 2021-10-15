prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_180100 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2018.04.04'
,p_release=>'18.1.0.00.45'
,p_default_workspace_id=>1451411821131674
,p_default_application_id=>102
,p_default_owner=>'MODCLIUNI'
);
end;
/
 
prompt APPLICATION 102 - ONLINE2
--
-- Application Export:
--   Application:     102
--   Name:            ONLINE2
--   Date and Time:   10:35 Friday October 15, 2021
--   Exported By:     CESAR.PATINO
--   Flashback:       0
--   Export Type:     Page Export
--   Version:         18.1.0.00.45
--   Instance ID:     227337033812485
--

prompt --application/pages/delete_03004
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>3004);
end;
/
prompt --application/pages/page_03004
begin
wwv_flow_api.create_page(
 p_id=>3004
,p_user_interface_id=>wwv_flow_api.id(2320212979319079)
,p_name=>'Reexpedir Tarjeta'
,p_step_title=>'Reexpedir Tarjeta'
,p_allow_duplicate_submissions=>'N'
,p_warn_on_unsaved_changes=>'N'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>wwv_flow_api.id(5430432261374362)
,p_last_updated_by=>'CESAR.PATINO'
,p_last_upd_yyyymmddhh24miss=>'20211015092130'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(26536578826411233)
,p_plug_name=>unistr('solicitar reexpedici\00F3n')
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(2379936821322523)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(26536925191411237)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(26536578826411233)
,p_button_name=>'Reexpedir'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(2432156460322594)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Reexpedir'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(30391293982999908)
,p_branch_action=>'f?p=&APP_ID.:3013:&SESSION.::&DEBUG.:RP,3013::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>10
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(26536712481411235)
,p_name=>'P3004_TARHAB'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(26536578826411233)
,p_prompt=>'Tarhab'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select DISTINCT nvl(razon_social,ENTIDAD.nombre||'' ''||apellido)||'' - ''||tpd.abreviacion||'' ''||ENTIDAD.documento entidad, ENTIDAD.pk_ent_Codigo ',
'from MODCLIUNI.CLITBLVINCUL vincul',
'JOIN modcliuni.clitblentida entidad',
'ON vincul.clitblentida_pk_ent_codigo = entidad.pk_ent_codigo',
'and vincul.clitblentida_pk_ent_codigo1=:P3004_ENTIDAD',
'JOIN MODCLIUNI.CLITBLTIPDOC tpd',
'ON entidad.clitbltipdoc_pk_td_codigo=tpd.pk_td_codigo'))
,p_lov_cascade_parent_items=>'P3004_ENTIDAD'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(2431590093322594)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NOT_ENTERABLE'
,p_attribute_02=>'FIRST_ROWSET'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(26536859663411236)
,p_name=>'P3004_TARJETAS'
,p_is_required=>true
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(26536578826411233)
,p_prompt=>'Productos'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select cuenta.nombre_tartblcuenta',
'        ||'' No: ''||tarjeta.numero',
'        ||'' Identificador: ''|| nvl(tarjeta.identificador,''-'') ',
'        ||'' Id_Empresa ''||tarjeta.ID_EMPRESA ',
'        ||'' ESTADO: ''||estadotar.nombre "TARJETA",tarjeta.pk_tarjet_codigo',
'from  MODTARHAB.tartblcuenta cuenta',
'JOIN MODTARHAB.tartbltarjet tarjeta',
'ON CUENTA.PK_TARTBLCUENTA_CODIGO=tarjeta.PK_TARTBLCUENTA_CODIGO and cuenta.pk_ent_codigo_th=:P3004_TARHAB',
'JOIN MODTARHAB.tartblesttar estadotar',
'ON estadotar.pk_esttar_codigo=tarjeta.pk_esttar_codigo',
'--and tarjeta.pk_esttar_codigo in (6,7,8,18)',
'and tarjeta.pk_esttar_codigo not in (15,17,16)',
'and tarjeta.tipo_registro=1;'))
,p_lov_display_null=>'YES'
,p_lov_cascade_parent_items=>'P3004_TARHAB'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(2431590093322594)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NOT_ENTERABLE'
,p_attribute_02=>'FIRST_ROWSET'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(30121094378427141)
,p_name=>'P3004_CUSTODIOANT'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(26536578826411233)
,p_prompt=>'Custodio Seleccionado en el pedido anterior'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(2431590093322594)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(30121524093427146)
,p_name=>'P3004_CUSTODIOSACTIVOS'
,p_is_required=>true
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(26536578826411233)
,p_prompt=>'Custodiosactivos'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT DISTINCT entidad.nombre||'' ''||entidad.apellido||'' ''||entidad.documento custodio,entidad.pk_ent_codigo',
'FROM  MODCLIUNI.CLITBLVINCUL vincul',
'JOIN MODCLIUNI.CLITBLENTIDA entidad',
'ON vincul.clitblentida_pk_ent_codigo=entidad.pk_ent_codigo',
'where vincul.fecha_fin is null',
'and vincul.clitblentida_pk_ent_codigo1=:P3004_ENTIDAD',
'and vincul.clitblcampan_pk_campan_codigo=:P3004_CAMPANA',
'and vincul.CLITBLTIPVIN_PK_TIPVIN_CODIGO=46'))
,p_lov_cascade_parent_items=>'P3004_ENTIDAD,P3004_CAMPANA'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(2431590093322594)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NOT_ENTERABLE'
,p_attribute_02=>'FIRST_ROWSET'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(30121627035427147)
,p_name=>'P3004_ENTIDAD'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(26536578826411233)
,p_prompt=>'Entidad'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT  ',
'   DISTINCT NVL(en.razon_social, en.nombre||'' ''|| en.apellido)||'' ''||en.documento cliente,  en.PK_ENT_CODIGO codigo',
'FROM MODCLIUNI.CLITBLENTIDA en',
'    INNER JOIN MODCLIUNI.CLITBLVINCUL vn ON en.pk_ent_codigo = vn.clitblentida_pk_ent_codigo',
'    INNER JOIN MODCLIUNI.CLITBLTIPVIN tv ON tv.pk_tipvin_codigo = vn.clitbltipvin_pk_tipvin_codigo',
'    INNER JOIN MODCOMERC.COMTBLCOTIZA cot ON cot.pk_entida_cliente=en.pk_ent_codigo',
'    INNER JOIN MODCOMERC.COMTBLPROCES pro ON cot.pk_cotiza_codigo=pro.pk_cotiza_codigo',
'WHERE vn.fecha_actualizacion IS NULL',
'    AND vn.usuario_actualizacion IS NULL',
'    AND vn.fecha_fin is null',
'    AND tv.pk_tipvin_codigo = 50',
'    AND vn.clitblentida_pk_ent_codigo1 = 47',
'   -- AND  en.clitblestent_pk_est_codigo in( 23,3)',
'   -- AND cot.pk_estado_codigo=1',
'  --  AND pro.pk_estado_codigo=1'))
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(2431590093322594)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NOT_ENTERABLE'
,p_attribute_02=>'FIRST_ROWSET'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(30121758493427148)
,p_name=>'P3004_VALOR'
,p_is_required=>true
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(26536578826411233)
,p_prompt=>'Valor reexpedicion'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(2431590093322594)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(30260302135029426)
,p_name=>'P3004_CAMPANA'
,p_is_required=>true
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(26536578826411233)
,p_prompt=>'Campana'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT DISTINCT campana.nombre,campana.PK_CAMPAN_CODIGO',
'FROM  MODCLIUNI.CLITBLVINCUL vincul',
'JOIN MODCLIUNI.CLITBLCAMPAN campana',
'ON vincul.clitblcampan_pk_campan_codigo=campana.PK_CAMPAN_CODIGO',
'where vincul.fecha_fin is null',
'and vincul.clitblentida_pk_ent_codigo1=:P3004_ENTIDAD'))
,p_lov_cascade_parent_items=>'P3004_ENTIDAD'
,p_ajax_optimize_refresh=>'Y'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(2431590093322594)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(30260447367029427)
,p_name=>'P3004_COORDINADOR'
,p_is_required=>true
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(26536578826411233)
,p_prompt=>'Coordinador'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT DISTINCT entidad.nombre||'' ''||entidad.apellido||'' ''||entidad.documento coordinador,entidad.pk_ent_codigo',
'FROM  MODCLIUNI.CLITBLVINCUL vincul',
'JOIN MODCLIUNI.CLITBLENTIDA entidad',
'ON vincul.clitblentida_pk_ent_codigo=entidad.pk_ent_codigo',
'where vincul.fecha_fin is null',
'and vincul.clitblentida_pk_ent_codigo1=:P3004_ENTIDAD',
'and vincul.clitblcampan_pk_campan_codigo=:P3004_CAMPANA',
'and vincul.CLITBLTIPVIN_PK_TIPVIN_CODIGO=45'))
,p_lov_cascade_parent_items=>'P3004_ENTIDAD,P3004_CAMPANA'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(2431590093322594)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NOT_ENTERABLE'
,p_attribute_02=>'FIRST_ROWSET'
);
wwv_flow_api.create_page_validation(
 p_id=>wwv_flow_api.id(30257926833029402)
,p_validation_name=>'NUMERICO'
,p_validation_sequence=>10
,p_validation=>'P3004_VALOR'
,p_validation_type=>'ITEM_IS_NUMERIC'
,p_error_message=>'el valor debe ser numerico sin puntos ni comas.'
,p_associated_item=>wwv_flow_api.id(30121758493427148)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(30121113312427142)
,p_name=>'cargar custodio'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P3004_TARJETAS'
,p_condition_element=>'P3004_TARJETAS'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(30121269111427143)
,p_event_id=>wwv_flow_api.id(30121113312427142)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ''Custodio: ''|| custodio.nombre||'' ''||custodio.apellido ||'' ''||custodio.DOCUMENTO ',
'||'' - Coordinador: ''|| coordinador.nombre||'' ''||coordinador.apellido ||'' ''||coordinador.DOCUMENTO custodio',
'INTO :P3004_CUSTODIOANT',
'from  MODTARHAB.tartblcuenta cuenta',
'JOIN MODTARHAB.tartbltarjet tarjeta',
'ON CUENTA.PK_TARTBLCUENTA_CODIGO=tarjeta.PK_TARTBLCUENTA_CODIGO ',
'JOIN MODCLIUNI.CLITBLENTIDA custodio',
'ON tarjeta.PK_ENT_CODIGO_CUSTODIO=custodio.PK_ENT_CODIGO  ',
'JOIN MODALISTA.ALITBLDETPED detped',
'on detped.pk_detped_codigo=tarjeta.pk_detped_codigo and  tarjeta.pk_tarjet_codigo=:P3004_TARJETAS',
'JOIN MODALISTA.alitblpedido pedido',
'on pedido.pk_pedido_codigo=detped.pk_pedido',
'JOIN MODTARHAB.tartblesttar estadotar',
'ON estadotar.pk_esttar_codigo=tarjeta.pk_esttar_codigo',
'JOIN MODCLIUNI.CLITBLENTIDA coordinador',
'ON coordinador.pk_ent_codigo=pedido.pk_coordinador;',
'--WHERE tarjeta.pk_tarjet_codigo=1958;',
'',
' ',
''))
,p_attribute_02=>'P3004_TARJETAS'
,p_attribute_03=>'P3004_CUSTODIOANT'
,p_attribute_04=>'N'
,p_stop_execution_on_error=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(2550680002694401)
,p_event_id=>wwv_flow_api.id(30121113312427142)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select pedido.pk_campan_codigo',
'into :P3004_CAMPANA',
'from  MODTARHAB.tartbltarjet tarjeta',
'JOIN MODALISTA.ALITBLDETPED detped',
'on detped.pk_detped_codigo=tarjeta.pk_detped_codigo and  tarjeta.pk_tarjet_codigo=:P3004_TARJETAS',
'JOIN MODALISTA.alitblpedido pedido',
'on pedido.pk_pedido_codigo=detped.pk_pedido;'))
,p_attribute_02=>'P3004_TARJETAS'
,p_attribute_03=>'P3004_CAMPANA'
,p_attribute_04=>'N'
,p_stop_execution_on_error=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(30121357068427144)
,p_event_id=>wwv_flow_api.id(30121113312427142)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3004_CUSTODIOANT'
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(30121903240427150)
,p_name=>'consultar parametro valor reexpedicion'
,p_event_sequence=>20
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(30257884484029401)
,p_event_id=>wwv_flow_api.id(30121903240427150)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'select valor_parametro into :P3004_VALOR from modgeneri.gentblpargen where pk_pargen_codigo=71;'
,p_attribute_03=>'P3004_VALOR'
,p_attribute_04=>'N'
,p_stop_execution_on_error=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(26537138553411239)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Reexpedir'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'varpktarjeta number;',
'varpkproducto number;',
'varpkbinproducto number;',
'VARRESUL VARCHAR2(1000);',
'VALORREEXPIDE MODGENERI.GENTBLPARGEN.VALOR_PARAMETRO%TYPE;',
'varcuenta varchar2(100);',
'varidempresa varchar2(100);',
'vardetalle varchar2(1000 char);',
'varpedido  number:=null;',
'varpersonalizador MODCLIUNI.CLITBLENTIDA.PK_ENT_CODIGO%TYPE:=3; --- CODIGO DEL PERSONALIZADOR PARA REEXPEDICION HOGIER',
'begin',
'',
' BEGIN',
'        SELECT  cuenta.PK_TARTBLCUENTA_CODIGO, cuenta.PK_PRODUC_CODIGO into varcuenta, varpkproducto',
'                FROM MODTARHAB.tartblcuenta cuenta',
'                INNER JOIN MODTARHAB.tartbltarjet tarjeta ',
'                ON cuenta.pk_tartblcuenta_codigo = tarjeta.PK_TARTBLCUENTA_CODIGO',
'               -- AND ta.pk_esttar_codigo = 1',
'                where tarjeta.PK_TARJET_CODIGO=:P3004_TARJETAS;',
'                EXCEPTION ',
'         WHEN NO_DATA_FOUND THEn ',
unistr('                Raise_Application_Error(-20100,''No se encuentra n\00FAmero de cuenta'');'),
'        END;',
'        ',
'        ',
'        BEGIN',
'        SELECT  DISTINCT  binpro.pk_bin_producto_codigo',
'        into varpkbinproducto',
'        FROM MODCOMERC.COMTBLCOTIZA co',
'        INNER JOIN MODCOMERC.COMTBLPROCES pr ON pr.PK_COTIZA_CODIGO = co.pk_cotiza_codigo',
'        AND pr.pk_estado_codigo = 1',
'        AND  co.pk_estado_codigo =1',
'        INNER JOIN MODCOMERC.COMTBLPARAME pa ON pa.pk_proces_codigo = pr.pk_proces_codigo',
'        INNER JOIN MODPRODUC.PROTBLPRODUC p ON p.PK_PRODUC_CODIGO = pa.PK_PRODUCTO_CODIGO ',
'        AND p.pk_tippro_codigo = 1 ',
'        INNER JOIN  MODPRODUC.PROTBLBINPRODUCTO binpro ',
'        ON pa.pk_bin_producto_codigo= binpro.pk_bin_producto_codigo',
'        AND pa.PK_PRODUCTO_CODIGO=binpro.PK_PRODUC_CODIGO',
'        and pa.pk_producto_codigo=varpkproducto',
'        and binpro.pk_bin_producto_codigo is not null',
'        INNER JOIN MODPRODUC.PROTBLBINES bines ',
'        ON binpro.PK_BINES_CODIGO=bines.PK_BINES_CODIGO',
'        INNER JOIN MODPRODUC.PROTBLBANCOS banco',
'        ON bines.pk_banco_codigo=banco.pk_banco_codigo',
'        WHERE  PK_ENTIDA_CLIENTE = :P3004_ENTIDAD',
'        AND co.PK_CAMPANA_CODIGO=:P3004_CAMPANA',
'        ;',
'        EXCEPTION',
'        WHEN NO_DATA_FOUND THEN ',
'        Raise_Application_Error(-20100,''No se encuentra entidad de realce'');',
'        END;',
'        ',
'       -- Raise_Application_Error(-20100,''bin producto ''||varpkbinproducto);',
'        ',
'        BEGIN',
'        ',
'        SELECT ID_EMPRESA ',
'        INTO varidempresa ',
'        FROM  MODTARHAB.tartbltarjet ',
'        WHERE PK_TARJET_CODIGO=:P3004_TARJETAS;',
'        ',
'        EXCEPTION',
'        WHEN NO_DATA_FOUND THEN ',
'        ',
unistr('        Raise_Application_Error(-20100,''No se encuentra n\00FAmero de Tarjeta'');'),
'        END;',
'',
'',
'        VALORREEXPIDE:=:P3004_VALOR;',
'        IF(VALORREEXPIDE IS NULL ) THEN ',
'        Raise_Application_Error(-20100,''NO SE DILIGENCIO EL VALOR DE REEXPEDICION'');',
'      END IF;',
'modgeneri.genpkgzeus.PRCREEXPEDIRZEUS(PKEMPRESA=>:P3004_ENTIDAD',
'                                      ,PKPRODUCTO=>varpkproducto',
'                                      ,PKBINPRODUCTO=>varpkbinproducto',
'                                      ,PK_ENTIDA_TH=>:P3004_TARHAB',
'                                      ,PARVALOR=>VALORREEXPIDE',
'                                      ,PKTARJETAACTUAL=>:P3004_TARJETAS',
'                                      ,PKCUENTAACTUAL=>varcuenta',
'                                      ,PK_IDEMPRESA=>varidempresa',
'                                      ,PARPKCOORDINADOR=>:P3004_COORDINADOR',
'                                      ,PARPKCUSTODIO=>:P3004_CUSTODIOSACTIVOS',
'                                      ,PARCAMPANA=>:P3004_CAMPANA',
'                                      ,PARPERSONALIZADOR=>varpersonalizador',
'                                      ,PARPKPEDIDO=>varpedido',
'                                      ,PARRESULT=>VARRESUL',
'                                      ,PARDETALLE=>vardetalle',
'                                      ,PAR_PK_TARJET_CODIGO=>:P3004_TARJETAS);',
'                                   ',
'                                  ',
'  if(VARRESUL!=1) then ',
'        Raise_Application_Error(-20700,''La tarjeta no se puede reexpedir en el core ''||vardetalle||'' Cod: ''||VARRESUL);                    ',
'     --Raise_Application_Error(-20700,''La tarjeta no se puede reexpedir en el core'');        ',
'end if;',
'',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(26536925191411237)
,p_process_success_message=>'solicitud de reexpedicion exitosa, proceda al proceso de envio de tarjetas reexpedidas.'
);
end;
/
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false));
commit;
end;
/
set verify on feedback on define on
prompt  ...done
