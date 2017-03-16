<?xml version="1.0" encoding="ISO-8859-1"?>
<ncl id="ebc" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
	<head>
		<!--Regioes-->
		<regionBase>
		<!--Região espaços na tela-->
		<region id="regiaoVideo" top="0"	right="0" 		width="100%"	height="100%"  	zIndex="0"/>
		<region id="rglogointer" top="71" left="114" 		width="54"  	height="49"  	zIndex="1"/>
		
		<!--Regiões Rodapé -->
		<region id="rgrodape" 	top="82.0%" 	left="130" 		width="1024" 	height="109" 	zIndex="1">
			<region id="rgLuarodape" 		top="18" 		left="170" 		width="810" 	height="55" 	zIndex="2"/>
		</region>
	</regionBase>
		
		<!--Descritores-->
		<descriptorBase>
			<!-- Descritores de Midia -->
			<descriptor id="desVideo" 			region="regiaoVideo" 			/>
			<descriptor id="dLGInter"			region="rglogointer"			/>		
			<!-- Descritores de Rodapé -->
			<descriptor id="dRodape"			region="rgrodape" 				/>
			<descriptor id="dLuaRodape" 		region="rgLuarodape" 			/>
		</descriptorBase>
		
		<!--Conectores-->
		<connectorBase>
			<importBase alias="conn" documentURI="connectorBase.ncl"/>
		</connectorBase>
	</head>
	
	<body>
		<!--Porta de Entrada-->
		<port id="pVideo" component="video"/>
		<port id="plogointeratividade" component="LG_Inter_EBC"/>
		
		<!-- Midias Iniciais -->
		<!-- -->
		<media id="video" src="sbtvd-ts://0" descriptor="desVideo">
			<property name="bounds"/>
		</media>
		
		<!-- 
		<media id="video" src="noticias/media/BG_teste.jpg" descriptor="desVideo">
			<property name="bounds" value="0,0,100%,100%"/>
		</media>
		-->
		<media id="LG_Inter_EBC" src="imagens/logo_EBC_INTERATIVA.png" descriptor="dLGInter"/>
		
		<media id="BaseNoticias" src="noticias/media/tarja-crop.png" descriptor="dRodape"/>
		
		<media id="TxtNoticias" src="noticias/main_rodape.lua" type="application/x-ginga-NCLua" descriptor="dLuaRodape">
			<property name="Control"/>	
		</media>
		
		<media id="luatimer_rodape" src="noticias/timer_rodape.lua" 	descriptor="dLuaRodape" type="application/x-ginga-NCLua">
    		<property name="sinal7"/>
    		<property name="sinal8"/>
	 	</media>
		
		<!-- AÇÕES-->
		
		<!-- Exibe Noticias -->
		<!--- BoTao Azul-->
		<link xconnector="conn#onKeySelectionStartNStopN">
			<bind role="onSelection" component="LG_Inter_EBC">
				<bindParam name="keyCode" value="BLUE"/>
			</bind>
			<bind role="start" component="BaseNoticias"/>
			<bind role="start" component="TxtNoticias"/>
			<bind role="start" component="luatimer_rodape"/>
			<bind role="stop" component="LG_Inter_EBC"/>
		</link>
		
		<link xconnector="conn#onKeySelectionStartNStopN">
			<bind role="onSelection" component="LG_Inter_EBC">
				<bindParam name="keyCode" value="ENTER"/>
			</bind>
			<bind role="start" component="BaseNoticias"/>
			<bind role="start" component="TxtNoticias"/>
			<bind role="start" component="luatimer_rodape"/>
			<bind role="stop" component="LG_Inter_EBC"/>
		</link>
		
		<!-- Fecha Noticias abre Icone -->
		<link xconnector="conn#onKeySelectionStartNStopN">
			<bind role="onSelection" component="BaseNoticias">
				<bindParam name="keyCode" value="GREEN"/>
			</bind>
			<bind role="stop" component="BaseNoticias"/>
			<bind role="stop" component="TxtNoticias"/>
			<bind role="stop" component="luatimer_rodape"/>
			<bind role="start" component="LG_Inter_EBC"/>
		</link>	
		
		<!-- Resize de Tela -->
		<link xconnector="conn#onBeginSet">
			<bind role="onBegin" component="BaseNoticias"/>
			<bind role="set" component="video" interface="bounds">
				<bindParam name="var" value="0,0,100%,84.5%"/>
			</bind>
		</link>
		
		<link xconnector="conn#onEndSet">
			<bind role="onEnd" component="BaseNoticias"/>
			<bind role="set" component="video" interface="bounds">
				<bindParam name="var" value="0,0,100%,100%"/>
			</bind>
		</link>
		
		<!-- Timer de Noticias -->
		<link xconnector="conn#onEndAttributionStop">
      		<bind role="onEndAttribution" component="luatimer_rodape" interface="sinal7"/>
     			<bind role="stop" component="TxtNoticias" />
		</link>
		<link xconnector="conn#onEndAttributionStart">
      		<bind role="onEndAttribution" component="luatimer_rodape" interface="sinal8"/>
     			<bind role="start" component="TxtNoticias" />
		</link>
		<!-- Navega Noticias -->
		<!--seta acima-->
		<link xconnector="conn#onKeySelectionSet">
			<bind role="onSelection" component="BaseNoticias">
				<bindParam name="keyCode" value="CURSOR_DOWN"/>
			</bind>
			<bind role="set" component="TxtNoticias" interface="Control">
				<bindParam name="var" value="CURSOR_DOWN"/>
			</bind>
		</link>
		<!--seta abaixo-->
		<link xconnector="conn#onKeySelectionSet">
			<bind role="onSelection" component="BaseNoticias">
				<bindParam name="keyCode" value="CURSOR_UP"/>
			</bind>
			<bind role="set" component="TxtNoticias" interface="Control">
				<bindParam name="var" value="CURSOR_UP"/>
			</bind>
		</link>
		<!--seta enter/ok-->
		<link xconnector="conn#onKeySelectionSet">
			<bind role="onSelection" component="BaseNoticias">
				<bindParam name="keyCode" value="ENTER"/>
			</bind>		
			<bind role="set" component="TxtNoticias" interface="Control">
				<bindParam name="var" value="ENTER"/>
			</bind>
		</link>
	</body>
</ncl>
