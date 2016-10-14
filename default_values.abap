NITIALIZATION.
" con las siguientes líneas hacemos que el parametro de selección s_fecha tenga puesto por defecto el año en curso"
  concatenate sy-datum(4) '0101' into s_fecha-low.
  concatenate sy-datum(4) '1231' into s_fecha-high.
  APPEND s_fecha.
  sy-title = 'Informe proyectos'.

   DATA : lt_user_params TYPE STANDARD TABLE OF usparam.
" con la siguiente llamada recuperamos los parámetros del usuario lanza la transacción"
  CALL FUNCTION 'SUSR_USER_PARAMETERS_GET'
    EXPORTING
      user_name           = syst-uname
      with_text              = 'X'
    TABLES
      user_parameters   = lt_user_params
    EXCEPTIONS
      user_name_not_exist = 1.
  data: ls_user_param  LIKE LINE OF lt_user_params.
" en este usuario tiene en el parámetro WRK su centro"
  READ TABLE lt_user_params into ls_user_param WITH KEY parid = 'WRK'.
  if sy-subrc = 0.
" asignamos para el parámetro s_centro el centro que tenga el usuario en sus parámetros de usuario"
    s_centro-low = ls_user_param-parva.
    append s_centro.
  endif. 

