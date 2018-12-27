<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.2" tiledversion="1.2.1" name="tile" tilewidth="32" tileheight="32" tilecount="100" columns="10">
 <image source="tile.png" width="320" height="320"/>
 <tile id="0">
  <properties>
   <property name="Solido" type="bool" value="true"/>
  </properties>
 </tile>
 <tile id="1">
  <properties>
   <property name="Subida" type="bool" value="true"/>
  </properties>
  <objectgroup draworder="index">
   <object id="1" x="0" y="0">
    <properties>
     <property name="tipo" type="int" value="1"/>
    </properties>
    <polygon points="0,0 0.015625,32 32.0391,32"/>
   </object>
  </objectgroup>
 </tile>
 <tile id="2">
  <properties>
   <property name="Subida" type="bool" value="true"/>
  </properties>
  <objectgroup draworder="index">
   <object id="1" x="0" y="32">
    <properties>
     <property name="tipo" type="int" value="2"/>
    </properties>
    <polygon points="0,0 31.9961,0 32.0078,-31.9844"/>
   </object>
  </objectgroup>
 </tile>
 <tile id="3">
  <properties>
   <property name="Subida" type="bool" value="true"/>
  </properties>
  <objectgroup draworder="index">
   <object id="2" x="0" y="0">
    <properties>
     <property name="tipo" type="int" value="3"/>
    </properties>
    <polygon points="0,0.00390625 0.00390625,32.0078 32,0"/>
   </object>
  </objectgroup>
 </tile>
 <tile id="4">
  <properties>
   <property name="Subida" type="bool" value="true"/>
  </properties>
  <objectgroup draworder="index">
   <object id="1" x="32" y="0">
    <properties>
     <property name="tipo" type="int" value="4"/>
    </properties>
    <polygon points="0,0 0.0078125,32 -32.0078,0.0078125"/>
   </object>
  </objectgroup>
 </tile>
 <tile id="5">
  <properties>
   <property name="plataforma" type="bool" value="true"/>
  </properties>
  <objectgroup draworder="index">
   <object id="2" x="0" y="15" width="32" height="17">
    <properties>
     <property name="solido" type="bool" value="true"/>
    </properties>
   </object>
  </objectgroup>
 </tile>
 <tile id="10">
  <properties>
   <property name="Solido" type="bool" value="true"/>
  </properties>
 </tile>
 <tile id="11">
  <properties>
   <property name="Subida" type="bool" value="true"/>
  </properties>
  <objectgroup draworder="index">
   <object id="1" x="0" y="0">
    <properties>
     <property name="tipo" type="int" value="1"/>
    </properties>
    <polygon points="0,0 -0.00994318,31.9901 32.0355,31.9979"/>
   </object>
  </objectgroup>
 </tile>
 <tile id="12">
  <properties>
   <property name="Subida" type="bool" value="true"/>
  </properties>
  <objectgroup draworder="index">
   <object id="1" x="0" y="32">
    <properties>
     <property name="tipo" type="int" value="2"/>
    </properties>
    <polygon points="-0.00390625,0 31.9961,0 32,-31.9961"/>
   </object>
  </objectgroup>
 </tile>
 <tile id="13">
  <properties>
   <property name="Subida" type="bool" value="true"/>
  </properties>
  <objectgroup draworder="index">
   <object id="1" x="0" y="0">
    <properties>
     <property name="tipo" type="int" value="3"/>
    </properties>
    <polygon points="0,0.00390625 32.0156,-0.00390625 -0.00390625,32.0234"/>
   </object>
  </objectgroup>
 </tile>
 <tile id="14">
  <properties>
   <property name="Subida" type="bool" value="true"/>
  </properties>
  <objectgroup draworder="index">
   <object id="1" x="0" y="0">
    <polygon points="0,0 31.9961,-0.0078125 32.0039,32"/>
   </object>
  </objectgroup>
 </tile>
 <tile id="23">
  <properties>
   <property name="Solido" type="bool" value="true"/>
  </properties>
 </tile>
</tileset>
