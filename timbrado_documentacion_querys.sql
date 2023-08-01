    /*lISTADO DE CATALOGO DE EMPRESAS*/
    select distinct id,nombre from empresas where inactiva=0 order by nombre desc
    /*PRUEBAS*/

    /*NOMINA INTERNA VALUDA EB BACKEND*/
    Select * from catalogo_empresas_nomina_interna  

    /*QUERY DESPUES DE CALCULAR EL PERIODO Y DAR CLICK EN CARGAR*/


    /*
    datos que aparecen despues que filtras el id empresa  y periodos

    Codigo | Fecha_inicial | Fecha_final | Estatus | Persepciones  | Otros      | Seguridad Social |  Deducciones  | Otros_descuentos  | Total   | Finiquio
    -------|---------------|-------------|---------|---------------|------------|------------------|---------------|-------------------|---------|---------
    161	     2023-07-03	     2023-07-09	   CERRADO	    9611.52	     11259.80	    242.92	           591.47	        0	            20036.93	

    */
    select a.id_empresa AS Codigo,a.fecha1 as Fecha_inicial,a.fecha2 as Fecha_final,if (a.cerrado=0,'ABIERTO','CERRADO') as Estatus,if( isnull((select sum( if (isnull(b.monto),0,b.monto) + if (isnull(b.isr),0,b.isr))from periodo_calculo_grava_exenta b where b.id_empresa=a.id_empresa and a.fecha1=b.fecha1 and a.fecha2=b.fecha2 )),0,(select sum( if (isnull(b.monto),0,b.monto) + if (isnull(b.isr),0,b.isr))from periodo_calculo_grava_exenta b where b.id_empresa=a.id_empresa and a.fecha1=b.fecha1 and a.fecha2=b.fecha2 )) as Percepciones,if ( isnull((select sum( if (isnull(e.monto),0,e.monto) + if (isnull(e.isr),0,e.isr)) from periodo_calculo_grava_exenta_fiscal  e where e.id_empresa=a.id_empresa and a.fecha1=e.fecha1 and a.fecha2=e.fecha2 )),0, (select sum( if (isnull(e.monto),0,e.monto) + if (isnull(e.isr),0,e.isr)) from periodo_calculo_grava_exenta_fiscal  e where e.id_empresa=a.id_empresa and a.fecha1=e.fecha1 and a.fecha2=e.fecha2 )) as Otros,if ( isnull((select sum(if (isnull(f.monto),0,f.monto)) from periodo_calculo_imss_Seguro f where f.id_empresa=a.id_empresa and a.fecha1=f.fecha1 and a.fecha2=f.fecha2 )),0,(select sum(if (isnull(f.monto),0,f.monto)) from periodo_calculo_imss_Seguro f where f.id_empresa=a.id_empresa and a.fecha1=f.fecha1 and a.fecha2=f.fecha2 )) as Seguridad_social,if ( isnull((select sum(if (isnull(c.monto),0,c.monto)) from periodo_calculo_deducciones c where c.id_empresa=a.id_empresa and a.fecha1=c.fecha1 and a.fecha2=c.fecha2 )),0,(select sum(if (isnull(c.monto),0,c.monto)) from periodo_calculo_deducciones c where c.id_empresa=a.id_empresa and a.fecha1=c.fecha1 and a.fecha2=c.fecha2 )) as Deducciones,if ( isnull((select sum(if (isnull(d.monto),0,d.monto)) from periodo_calculo_deducciones_fiscal d where d.id_empresa=a.id_empresa and a.fecha1=d.fecha1 and a.fecha2=d.fecha2 )),0,(select sum(if (isnull(d.monto),0,d.monto)) from periodo_calculo_deducciones_fiscal d where d.id_empresa=a.id_empresa and a.fecha1=d.fecha1 and a.fecha2=d.fecha2 )) as Otros_descuentos,((if ( isnull((select sum( if (isnull(b.monto),0,b.monto) + if (isnull(b.isr),0,b.isr))from periodo_calculo_grava_exenta b where b.id_empresa=a.id_empresa and a.fecha1=b.fecha1 and a.fecha2=b.fecha2 )),0,(select sum( if (isnull(b.monto),0,b.monto) + if (isnull(b.isr),0,b.isr))from periodo_calculo_grava_exenta b where b.id_empresa=a.id_empresa and a.fecha1=b.fecha1 and a.fecha2=b.fecha2 ))+if ( isnull((select sum( if (isnull(e.monto),0,e.monto) + if (isnull(e.isr),0,e.isr))from periodo_calculo_grava_exenta_fiscal  e where e.id_empresa=a.id_empresa and a.fecha1=e.fecha1 and a.fecha2=e.fecha2 )),0,(select sum( if (isnull(e.monto),0,e.monto) + if (isnull(e.isr),0,e.isr))from periodo_calculo_grava_exenta_fiscal  e where e.id_empresa=a.id_empresa and a.fecha1=e.fecha1 and a.fecha2=e.fecha2 ) ))-(if ( isnull((select sum(if (isnull(c.monto),0,c.monto)) from periodo_calculo_deducciones c where c.id_empresa=a.id_empresa and a.fecha1=c.fecha1 and a.fecha2=c.fecha2 )),0,(select sum(if (isnull(c.monto),0,c.monto)) from periodo_calculo_deducciones c where c.id_empresa=a.id_empresa and a.fecha1=c.fecha1 and a.fecha2=c.fecha2 ))+if ( isnull((select sum(if (isnull(d.monto),0,d.monto)) from periodo_calculo_deducciones_fiscal d where d.id_empresa=a.id_empresa and a.fecha1=d.fecha1 and a.fecha2=d.fecha2 )),0,(select sum(if (isnull(d.monto),0,d.monto)) from periodo_calculo_deducciones_fiscal d where d.id_empresa=a.id_empresa and a.fecha1=d.fecha1 and a.fecha2=d.fecha2 ))+if ( isnull((select sum(if (isnull(f.monto),0,f.monto)) from periodo_calculo_imss_Seguro f where f.id_empresa=a.id_empresa and a.fecha1=f.fecha1 and a.fecha2=f.fecha2 )),0,(select sum(if (isnull(f.monto),0,f.monto)) from periodo_calculo_imss_Seguro f where f.id_empresa=a.id_empresa and a.fecha1=f.fecha1 and a.fecha2=f.fecha2 )))) as Total,(IF(finiquito=1,'FINIQUITOS','')) AS FINIQUITO  from periodo_calculo a  inner join empresas empresas on empresas.id = a.id_empresa and empresas.formapago_nominafiscal <> 1 where  a.id_empresa='161' and  (a.fecha1>='2023-7-3' and  a.fecha2<='2023-7-9') and  a.cerrado=1 and a.nomina_Normal <> '8' order by cast(a.id_empresa as unsigned) ,a.fecha1,a.fecha2 desc



    /*Listado de empreados que pertenecen a la empresa previamente buscada al icual que el periodo
    
    id_empleado |nombre                            |rfc                | curp               | nss           | fecha_ingreso | total_percepcion_sa | total_deducciones_sa | seguridad_social_sa |total_persepcion_sc |total_deducciones_sc |   Total | registro_patronal | timbrado_sa | fecha_timbrado_sa | registro_patronal2 | timbrado_sc | fecha_timbrado_sc  | id_puesto  | id_departamento  | gastos_vida | solo_Asimilados | forma_pago       | numero_cuenta | entidad_federativa | tipo_contrato                                                   | rfclabora | banco | numero_cuenta(1) | cuenta_clabe        | tipo_jornada | sdi         | sindicalizado | registro_patronal(1) | fecha_antiguedad | observaciones | alias | destajista
    ------------|----------------------------------|-------------------|--------------------|---------------|---------------|---------------------|----------------------|---------------------|--------------------|---------------------|---------|-------------------|-------------|-------------------|--------------------|-------------|--------------------|------------|------------------|-------------|-----------------|------------------|---------------|--------------------|-----------------------------------------------------------------|-----------|-------|------------------|---------------------|--------------|-------------|---------------|----------------------|------------------|---------------|-------|-----------
    5987	      JOSE FRANCISCO AVILA PIMIENTA	    AIPF660908HP5	    AIPF660908HYNVMR09	    81866601784	   2022-04-18	  1060.08	            311.15	                25.84	                17.84	            0.00	            740.93	    47	                0		                            48              	0		                        1130	        235             	0	        0	            TRANSFERENCIA	    0470705966	    YUC             	Contrato de trabajo por tiempo determinado		                                72	    0470705966	    072849004707059662	    Diurna	        217.67	        0	            47	                2022-04-18			                        0
    7897	      ALVARO MANUEL CAN BRITO	        CABA000822BY5	    CABA000822HYNNRLA3		               2022-11-25	  0.00	                0.00	                0.00	                322.92	            0.00	            322.92	    0	                0		                            48              	0		                        1130	        235             	0	        1	            TRANSFERENCIA	    6574902859	    YUC             	Modalidades de contratación donde no existe relación de trabajo		            21	    6574902859	    021910065749028596		                0.00	        0	            0	                2022-11-25			                        0
    6754	      OBDULIO CASTILLO CAAMAL	        CACX760905PW1	    CXCO760905HYNSMB04	    84947627000	   2022-04-18	  1425.24	            0.00	                36.18	                750.22	            0.00	            2139.28	    47	                0		                            48              	0		                        1130	        235             	0	        0	            TRANSFERENCIA	    0447507706	    YUC             	Contrato de trabajo por tiempo determinado		                                72	    0447507706	    072910004475077067	    Diurna	        217.67	        0	            47	                2022-04-18			                        0
    7892	      JORGE RICARDO CHAN MAY	        CAMJ9910218W7	    CAMJ991021HYNHYR05		               2022-11-25	  0.00	                0.00	                0.00	                335.82	            0.00	            335.82	    0	                0		                            48              	0		                        1130	        235             	0	        1	            TRANSFERENCIA	    56850503878	    YUC             	Modalidades de contratación donde no existe relación de trabajo		            14	    56850503878	    014910568505038784		                0.00	        0	            0	                2022-11-25			                        0
    8293	      EMILIO JOSE CHAN SALAZAR	        CASE020801A54	    CASE020801HYNHLMA3		               2023-04-27	  0.00	                0.00	                0.00	                672.92	            0.00	            672.92	    0	                0		                            48              	0		                        1130	        235             	0	        1	            TRANSFERENCIA	    56863413770	    YUC             	Modalidades de contratación donde no existe relación de trabajo		            14	    56863413770	    014910568634137705		                0.00	        0	            0	                2023-04-27			                        0



    */

    /*----------------------------------------------------------------------------------------------------------------------------|
    
                PREPARANDO LA DATA PARA EL JSON
    
    ------------------------------------------------------------------------------------------------------------------------------|
    */
    /*SIN DATOS*/
    select id_empleado,etiqueta from etiquetas_primas where id_empresa='161' and fecha1='2023-7-3' and fecha2='2023-7-9'

    select id_empleado,etiqueta from etiquetas_vacaciones where id_empresa='161' and fecha1='2023-7-3' and fecha2='2023-7-9'

  


    select numero,curp from numero_empleado_timbrado
     /*
        SIN DATOS
        numero   |   curp
        ---------|--------

    */

    select * from parametros_timbrado_recibos


    /**
    timbrado_x_empresa |  validar_correo_timbrar
    -------------------|------------------------
    0							0
    */

    /*CONSULTA INFORMACION DEL PERIODO*/
    select * from periodo_Calculo where id_empresa='161' and fecha1='2023-7-3' and fecha2='2023-7-9'

    /*
          
    fecha1      | fecha2      | id_empresa | dias_pago | tipo_nomina | cerrado | nomina_normal | facturado_cliente | autorizado_timbrar_nomina | finiquito | sinnomina | financiado | efectivo_pagado | semana | estatus_factura | usuario | fecha_reg            |
   -------------|-------------|------------|-----------|-------------|---------|---------------|-------------------|---------------------------|-----------|-----------|------------|-----------------|--------|-----------------|---------|----------------------|
   2023-07-03	  2023-07-09	   161	        7	        SEMANAL	      1	        1	            1	                0	                          0         	0		                0	            0	            2	      ITAY	    2023-07-07 12:29:41
    */

    select * from url_webservices

    /*CREDENCIALES DEL url_webservices

        url		| usuario			 | clave	| id_servicio
      ----------|--------------------|----------|-----------
      Produccion	PIA110705HD7	 |Acceso$5	    45992986
    */



    select * from parametros

    /*

    consulta de parametros

    calculo_incapacidades | absorcion_isr | absorcion_imss | ruta_general_carpeta                 | modo_timbrado | clave_modif_cat_empleado | clave_modif_cat_empresa | clave_modif_cat_pagadora | pac | clave_timbrado | clave_retimbrar | clave_modificar_monto_factura | clave_modif_deducciones | clave_facturar_sin_pago
    ----------------------|---------------|----------------|--------------------------------------|---------------|--------------------------|-------------------------|--------------------------|-----|----------------|-----------------|-------------------------------|-------------------------|-----------------------------
    0	                    0	            0	            C:\RECIBOS ASIMILADOS CON DEDUCCIONES	    1	           a.2021	                a.2021	                    a.2021	                   1	1212	        1212	            a.2021	                        a.2021	               LOHAGOBAJOMIPROPIORIESGO
    
    */



    /*
        listado de registros de empleados relacionados con pagadora
    
    */


    select a.id,(select registro_patronal from pagadoras where id=a.registro_patronal) as registro_patronal,(select nombre from pagadoras where id=a.registro_patronal) as nombre_pagadora,(select c_riesgo from pagadoras where id=a.registro_patronal) as c_riesgo,(select rfc from pagadoras where id=a.registro_patronal) as rfc,(select cp from pagadoras where id=a.registro_patronal) as cp, a.registro_patronal as id_pagadora from empleados a where a.id in (select id_empleado from relacion_empleados where id_empresa='161')

/*

        id 	| registro_patronal    | nombre_pagadora 			                  | c_riesgo  	| rfc 				  | cp 		  | id_pagadora
        ----|----------------------|----------------------------------------------|-------------|---------------------|-----------|-------------
        5989	Z3811229106		       IMA CENTRO DE NEGOCIOS	                    1			  ICN150811IIA	        01020		15
        5999						   SIN ADMINISTRADORA	                        0	            -	                97000       0
        6755						   SIN ADMINISTRADORA	                        0	            -	                97000       0
        7892						   SIN ADMINISTRADORA	                        0	            -	                97000       0
        7893						   SIN ADMINISTRADORA	                        0	            -	                97000       0
        7894		                   SIN ADMINISTRADORA	                        0	            -	                97000       0
        7895		                   SIN ADMINISTRADORA	                        0	            -	                97000       0
        7896		                   SIN ADMINISTRADORA	                        0	            -	                97000       0
        7897		                   SIN ADMINISTRADORA	                        0	            -	                97000       0
        7958		                   SIN ADMINISTRADORA	                        0	            -	                97000       0
        8293		                   SIN ADMINISTRADORA	                        0	            -	                97000       0
        5989	Z3811229106	           IMA CENTRO DE NEGOCIOS	                    1	        ICN150811IIA	        01020       15
        5993	Z3811229106	           IMA CENTRO DE NEGOCIOS	                    1	        ICN150811IIA	        01020       15
        5994	Z3811229106	           IMA CENTRO DE NEGOCIOS	                    1	        ICN150811IIA	        01020       15
        5995	Z3811229106	           IMA CENTRO DE NEGOCIOS	                    1	        ICN150811IIA	        01020       15
        6756	Z3813446104	           LABELSA CORPORATIVO EMPRESARIAL S.A. DE C.V.	3	        LCE180416IDA	        01010       28
        6759	Z3813446104	           LABELSA CORPORATIVO EMPRESARIAL S.A. DE C.V.	3	        LCE180416IDA	        01010       28
        6833	Z3813446104	           LABELSA CORPORATIVO EMPRESARIAL S.A. DE C.V.	3	        LCE180416IDA	        01010       28
        6857	Z3813446104	           LABELSA CORPORATIVO EMPRESARIAL S.A. DE C.V.	3	        LCE180416IDA	        01010       28
        5987	Z3028657107	           KALMIN COORDINADORA DE SERVICIOS	            3	        KCS220224IZ1	        72160       47
        5988	Z3028657107	           KALMIN COORDINADORA DE SERVICIOS	            3	        KCS220224IZ1	        72160       47
        5990	Z3028657107	           KALMIN COORDINADORA DE SERVICIOS	            3	        KCS220224IZ1	        72160       47
        5991	Z3028657107	           KALMIN COORDINADORA DE SERVICIOS	            3	        KCS220224IZ1	        72160       47
        5992	Z3028657107	           KALMIN COORDINADORA DE SERVICIOS	            3	        KCS220224IZ1	        72160       47
        6752	Z3028657107	           KALMIN COORDINADORA DE SERVICIOS	            3	        KCS220224IZ1	        72160       47
        6753	Z3028657107	           KALMIN COORDINADORA DE SERVICIOS	            3	        KCS220224IZ1	        72160       47
        6754	Z3028657107	           KALMIN COORDINADORA DE SERVICIOS	            3	        KCS220224IZ1	        72160       47
        6757	Z3028657107	           KALMIN COORDINADORA DE SERVICIOS	            3	        KCS220224IZ1	        72160       47
        6856	Z3028657107	           KALMIN COORDINADORA DE SERVICIOS	            3	        KCS220224IZ1	        72160       47
        7084	Z3028657107	           KALMIN COORDINADORA DE SERVICIOS	            3	        KCS220224IZ1	        72160       47
        7130	Z3028657107	           KALMIN COORDINADORA DE SERVICIOS	            3	        KCS220224IZ1	        72160       47

*/

/*RUTA PARA ALMACENAR LOS XML*/

select ruta1,ruta2 from rutas_xml where id_empresa='161'
/*
ruta1   							 |ruta2
-------------------------------------|------------------------------------
\\server_nominafa\RECIBOS VALIDOS\SA	\\server_nominafa\RECIBOS VALIDOS\SC

*/

/*CALCULO DIAS DE AGUINALDO Y EMPRESA PAGADORA */

select dias_aguinaldo,id_pagadora,empresa_pagadora_fiscal,tipo_nomina,tabla30,mandar_fecha_antiguedad from empresas where id='161'

/*

dias_aguinaldo|id_pagadora | empresa_pagadora_fiscal | tipo_nomina | tabla30 | mandar_fecha_antiguedad
--------------|------------|-------------------------|-------------|---------|------------------------
15	    	  |47			 48						  SEMANAL			0						0

*/


/*
CONSULTA DATOS PAGADORA

*/
select * from pagadoras where id='47'

/*

  id  |	rfc	           | prima_riesgo |	pais  |	estado	|municipio	|nombre	                           | calle	                               |colonia	       |numint |numext |cruzamientos	                         | correo	 |registro_patronal	| curp   |	area_geografica	| pie_recibo  | imagen_archivo | nombre_representante_legal	  | apellido_paterno_representante_legal  |	apellido_materno_representante_legal  |	rfc_representante_legal	| correo_electronico_representante_legal  |	cp	      |  apoderado_legal  |	estado_dir	municipio_dir |	u1 | u3 | notario_publico	                   | numero_notario_publico	 | numero_acta |	fecha_acta	|lugar_notario_publico | folio_registro_publico	lugar_folio_registro_publico  |	letras_numero_acta	       | regimen_fiscal	| logo_imagen |	numero_libro  |	c_riesgo  |	nombre_corto  |	activa | pagadora_sa |	pagadora_sc	 corredor_publico	               | numero_corredor_publico
  ----|----------------|--------------|-------|---------|-----------|----------------------------------|---------------------------------------|---------------|-------|-------|-----------------------------------------|-----------|------------------|--------|------------------|-------------|----------------|------------------------------|---------------------------------------|---------------------------------------|-------------------------|-----------------------------------------|-----------|-------------------|-----------|---------------|----|----|--------------------------------------|-------------------------|-------------|----------------|----------------------|----------------------------------------------------- | ---------------------------|----------------|-------------|---------------|-----------|---------------|--------|-------------|--------------|----------------------------------|-------------------------
  47  |	KCS220224IZ1   | 2.598400000  | MEX	  | Puebla	|Puebla	    |KALMIN COORDINADORA DE SERVICIOS	 BOULEVARD LIBRAMIENTO CERRO SAN JUAN	REFORMA SUR	    101	    2308	entre calles 23 PONIENTE Y 25 PONIENTE,	 	            Z3028657107	 	            A	 	 	                                    LUIS ENRIQUE	                VILLA	                                   MENDOZA	 	 	                                                                                        72160	 	                      PUEBLA	PUEBLA	 	 	          CARLOS ENRIQUE HORNER VILLASEÑOR	        17	                    2044	        2022-02-24	  Estado de JALISCO	 	                                                    	dos mil cuarenta y cuatro			                         0	            3	        KALMIN	            0	        1	    0	          CARLOS ENRIQUE HORNER VILLASEÑOR	 17  

 */


/*
INCREMENTABLE

sucursales_pagadoras
*/
 
 select * from sucursales_pagadoras where id_pagadora='47'



/*

incrementable | id_pagadora	| callesuc | coloniasuc  | cruzamientossuc  | numintsuc  | numextsuc | cpsuc | estadosuc | municipiosuc
--------------|-------------|----------|-------------|------------------|------------|-----------|-------|------------|-------------
 303						47   


*/


/*
CERTIFICADOS
CON EL ID PAGADORA

*/
select * from certificados where id_pagadora='47'


/*
id_pagadora	  |  certificado	                                                                                               |  llave_privada	                                                                                                                                                       | clave_privada
--------------|----------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------
47	            \\server_nominafa\documentos importantes\CERTIFICADOS\CSD_KCS220224IZ1_20220412175023\00001000000512441374.cer	 \\server_nominafa\documentos importantes\CERTIFICADOS\CSD_KCS220224IZ1_20220412175023\CSD_KALMIN_COORDINADORA_DE_SERVICIOS_SA_DE_CV_KCS220224IZ1_20220412_174955.key	12K4lmin22

*/


/*
credenciales para el timbrado

*/

select * from cuentas_itimbre where UPPER(cuenta)='KCS220224IZ1'



/*
cuenta  |  liga 												   | usuario 	   | clave
--------|----------------------------------------------------------|---------------|--------
kcs220224iz1	https://facturacion33.itimbre.com/service.php		administrador	 #4BQzy78
*/


/*
---------------------------------------------------------------------------------------------------------------------------------------
                                                                                                                                      |  
                               CALCULO DATOS EMPLEADO                                                                                 |
                                                                                                                                      |
--------------------------------------------------------------------------------------------------------------------------------------|
*/



/*
	TIPO DE SALARIO DEL EMPLEADO
*/
select salario_diario,salario_hora,salario_fijo from salarios_diarios where id_empleado='5987'

/*
    	salario_diario	|salario_hora |	salario_fijo
	    ----------------|-------------|---------------
	    207.44				25.93		0.00

*/


/**
    PERIODO CALCULO 

*/

select dias_pago,tipo_nomina,nomina_normal,finiquito,semana from periodo_calculo where id_empresa='161' and fecha1='2023-7-3' and fecha2='2023-7-9'



/*
dias_pago	|tipo_nomina	|nomina_normal	|finiquito 	 |	semana
------------|---------------|---------------|------------|--------
    7			SEMANAL				1			 0			0

*/



/*
periodo_calculo_grava_exenta

NOT IN  tipo_concepto=7
*/

select sum(monto) as total from periodo_calculo_grava_exenta where id_empresa='161' and fecha1='2023-7-3' and fecha2='2023-7-9' and id_empleado='6757' and id_concepto not in (select formula from formula_nivel where tipo_concepto=7)


/**
	total
	------
	1452.08
 
*/

/*
periodo_calculo_grava_exenta

 IN  tipo_concepto=13
*/

select sum(monto) as total from periodo_calculo_grava_exenta where id_empresa='161' and fecha1='2023-7-3' and fecha2='2023-7-9' and id_empleado='6757' and id_concepto in (select formula from formula_nivel where tipo_concepto=13)

/*
    	total
	    ------
	

*/


/*
periodo_calculo_grava_exenta

--IN tipo_concepto=7


*/
select sum(monto) as total from periodo_calculo_grava_exenta where id_empresa='161' and fecha1='2023-7-3' and fecha2='2023-7-9' and id_empleado='6757' and id_concepto in (select formula from formula_nivel where tipo_concepto=7)


/*
 total
 ------
	
*/

/*
ISR

**/

select sum(isr) as total from periodo_calculo_grava_exenta where id_empresa='161' and fecha1='2023-7-3' and fecha2='2023-7-9' and id_empleado='6757'

/*
total
------
-26.84
*/

/* 
 MONTO IMSS

**/

select sum(monto) as total from periodo_calculo_imss_seguro where id_empresa='161' and fecha1='2023-7-3' and fecha2='2023-7-9' and id_empleado='6757'

/*
    total
    -----
    36.18
**/

/*
TOTAL DEDUCCIONES

*/

select sum(monto) as total from periodo_calculo_deducciones where id_empresa='161' and fecha1='2023-7-3' and fecha2='2023-7-9' and id_empleado='6757'

/*
    total
    -----
    0.00
	 
*/


/*
    flio pagador

*/
Select max(folio) as folio from folios_nomina_pagadoras where rfc='KCS220224IZ1' and ano= 2023

/*
    folio 
    ------
    1659
*/



/*ACTUALIXA EL VALOR TOMADO DE FOLIO*/
    update folios_nomina_pagadoras set folio=1659 where rfc='KCS220224IZ1' and ano= 2023

/*cCALCULA LA FECHA DE INGRESO*/

select fecha_ingreso,fecha_ingreso2 from empleados where id='5987';

/*
fecha_ingreso  |	fecha_ingreso2	
---------------|-----------------	
2022-04-18				2022-04-18

*/

/*OBTIENE EL VALOR DE FECHA MINIMA */

select min(fecha1) as fecha_minima1,min(fecha2) as fecha_minima2 from periodo_calculo where   id_empresa='161' AND fecha1='2023-7-3' and fecha2='2023-7-9';


/*
fecha_minima1 | fecha_minima2
--------------|---------------
2023-07-03		  2023-07-09
*/


/**FECHA BAJA*/

select fechabaja from empleados where id='5987'


/*
   
fecha_minima   |  fecha_minima2
---------------|----------------    
2023-07-03				2023-07-09

 
*/


/*OTRA FECHA MIIMA*/

select min(fecha1) as fecha_minima,min(fecha2) as fecha_minima2 from periodo_calculo_perfiles where id_empleado='5987' and id_empresa='161' AND fecha1='2023-7-3' and fecha2='2023-7-9'

/*
 fecha_minima   |  fecha_minima2
 ---------------|----------------    
 2023-07-03				2023-07-09
*/

/*
FALTAS

*/

select (ausentismo + incapacidad + maternidad) as faltas from incapacidades where  id_empresa='161' and  fecha1='2023-7-3' and  fecha2='2023-7-9' and  id_empleado='5987'

/*
    faltas       
    -------------
    2		

*/


/*
    *DEFINCION DE PUESTOS
*/
select departamento,puesto from puestos a join departamentos b on a.id_departamento=b.id_departamento  and a.id_empresa=b.id_empresa where a.id_empresa='161' and a.id_puesto='1130'

/*
    departamento |  puesto
    -------------|-----------
    OPERATIVO		OPERATIVO

*/

/*CONSULTA HUEVONA DE EMPLEADOS*/
select * from empleados where id='5987'



/*
cruce de informacion de

periodo_calculo_grava_exenta
formula_nivel
periodo_calculo_perfiles

*/

select a.monto,grava,exenta,isr,concepto,clave_sat,id_concepto,tipo_concepto  from periodo_calculo_grava_exenta a inner join formula_nivel b on a.id_concepto=b.formula  join periodo_calculo_perfiles c on c.id_empresa=a.id_empresa and c.fecha1=a.fecha1 and c.fecha2=a.fecha2 and a.id_empleado=c.id_empleado and a.id_concepto=c.id_formula where a.id_empresa='161' and a.fecha1='2023-7-3' and a.fecha2='2023-7-9' and a.id_empleado='5987' and ((a.monto>0 AND tipo_concepto<>30 AND tipo_concepto<>29 and clave_sat<>999 and tipo_concepto<>100) or (a.monto=0 and tipo_concepto=1))


/*
monto		| grava	  |exenta | isr |concepto | clave_sat | id_concepto | tipo_concepto
------------|---------|-------|-----|---------|-----------|-------------|---------------
 1037.20	  1037.20	 0.00   0.00  SUELDO			1	 SUELDO			 	1

*/

/*
  CALCULO DE VACACIONES
*/

select sum(monto) as vacaciones from periodo_calculo_perfiles where   id_empresa='161' and  fecha1='2023-7-3' and  fecha2='2023-7-9' and   id_empleado='5987' and  id_formula='VACACIONES'

/*
    vacaciones
   ------------


*/


/*
    consulta a esta tabla 
    periodo_calculo_grava_exenta
*/

select id_empleado,sum(monto) as monto,sum(grava) as grava,sum(exenta) as exenta from  periodo_calculo_grava_exenta c where  c.id_empresa='161' and  c.fecha1='2023-7-3' and  c.fecha2='2023-7-9' and  c.id_empleado='5987' and  c.id_concepto in ('100','VALES DE DESPENSA')   group by id_empleado


/*
monto |	concepto |	clave_sat |	id_concepto	 | tipo_concepto
------|----------|------------|--------------|--------------
				

*/


/*SUBSIDIO */

select a.monto,a.grava,a.exenta,a.isr,b.concepto,b.clave_sat,a.id_concepto,b.tipo_concepto,d.subsidio from periodo_calculo_grava_exenta a left join formula_nivel b on a.id_concepto=b.formula  left join periodo_calculo_perfiles c on  a.id_empresa=c.id_empresa and  a.fecha1=c.fecha1 and  a.fecha2=c.fecha2 and  a.id_empleado=c.id_empleado and  a.id_concepto=c.id_formula inner join periodo_calculo_subsidio_isr d on  d.id_empresa = a.id_empresa and  d.fecha1 = a.fecha1 and  d.fecha2 = a.fecha2 and  d.id_empleado = a.id_empleado where a.id_empresa='161' and  a.fecha1='2023-7-3' and  a.fecha2='2023-7-9' and  a.id_empleado='5987' and  (a.isr>0 or (a.isr<=0 and a.id_concepto = '101'))


/*
monto | grava | exenta | isr 		| concepto  | clave_sat | id_concepto | tipo_concepto | subsidio
------|	------|--------|------------|-----------|-----------|-------------|---------------|-----------	
0.00	 0.00	 0.00	  22.88			        				 101		     			81.55

*/


/*
    SUBSIDIO ISR
*/


select * from periodo_calculo_subsidio_isr  where id_empresa='161' and  fecha1='2023-7-3' and  fecha2='2023-7-9' and  id_empleado='5987' limit 1


/*
id_empleado |id_empresa | fecha1  	| fecha2    | id_concepto | subsidio	| isr
------------|-----------|-----------|-----------|-------------|-------------|-------	
5987		 161		  2023-07-03  2023-07-09				 81.55		 58.67

 */


/*
calculo relacion tablas


periodo_calculo_grava_exenta
formula_nivel
periodo_calculo_perfiles

*/

select a.monto,grava,exenta,isr,concepto,clave_sat,id_concepto,tipo_concepto from  periodo_calculo_grava_exenta a left join formula_nivel b on a.id_concepto=b.formula  left join periodo_calculo_perfiles c on  c.id_empresa=a.id_empresa and  c.fecha1=a.fecha1 and  c.fecha2=a.fecha2 and  c.id_empleado=a.id_empleado and  c.id_formula=a.id_concepto where a.id_empresa='161' and  a.fecha1='2023-7-3' and  a.fecha2='2023-7-9' and  a.id_empleado='5987' and  (tipo_concepto=30 or tipo_concepto=29 or clave_sat=999) and a.monto>0


/*
monto |	grava |	exenta	| isr |	concepto  |	clave_sat  | id_concepto  |	tipo_concepto
------|-------|---------|-----|-----------|------------|--------------|-------------

*/



/*
calculo 
tablas

periodo_calculo_deducciones
deducciones


*/
select monto,descripcion,clave_sat,id_deduccion from periodo_calculo_deducciones join deducciones on deducciones.id=id_deduccion where id_empresa='161' and fecha1='2023-7-3' and fecha2='2023-7-9' and id_empleado='5987' and monto>0

/*
MONTO   descripcion  clavsat   id_deduccion
-------|------------|---------|-------------------
311.15	INFONAVIT	   10	     INFONAVIT

*/

/*
calculo de faltas e incapacidad

*/

select (ausentismo + incapacidad + maternidad) as faltas,incapacidad_riesgo_trabajo,incapacidad_enfermedad_general,maternidad from incapacidades where  id_empresa='161' and  fecha1='2023-7-3' and  fecha2='2023-7-9' and  id_empleado='5987'

/*
faltas incapacidad_riesgo_trabajo	  incapacidad_enfermedad_general   maternidad   ausentismo
------|-----------------------------| ------------------------------ |-------------|------------
 2			0				            0								0			 2			


*/


