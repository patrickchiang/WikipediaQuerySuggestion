<?xml version="1.0" encoding="utf-8"?>
<serviceModel xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" name="QuerySuggest" generation="1" functional="0" release="0" Id="088e79e4-a12b-43e2-97bb-8c1ebd6591ef" dslVersion="1.2.0.0" xmlns="http://schemas.microsoft.com/dsltools/RDSM">
  <groups>
    <group name="QuerySuggestGroup" generation="1" functional="0" release="0">
      <componentports>
        <inPort name="Query:Endpoint1" protocol="http">
          <inToChannel>
            <lBChannelMoniker name="/QuerySuggest/QuerySuggestGroup/LB:Query:Endpoint1" />
          </inToChannel>
        </inPort>
      </componentports>
      <settings>
        <aCS name="Query:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" defaultValue="">
          <maps>
            <mapMoniker name="/QuerySuggest/QuerySuggestGroup/MapQuery:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" />
          </maps>
        </aCS>
        <aCS name="QueryInstances" defaultValue="[1,1,1]">
          <maps>
            <mapMoniker name="/QuerySuggest/QuerySuggestGroup/MapQueryInstances" />
          </maps>
        </aCS>
      </settings>
      <channels>
        <lBChannel name="LB:Query:Endpoint1">
          <toPorts>
            <inPortMoniker name="/QuerySuggest/QuerySuggestGroup/Query/Endpoint1" />
          </toPorts>
        </lBChannel>
      </channels>
      <maps>
        <map name="MapQuery:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" kind="Identity">
          <setting>
            <aCSMoniker name="/QuerySuggest/QuerySuggestGroup/Query/Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" />
          </setting>
        </map>
        <map name="MapQueryInstances" kind="Identity">
          <setting>
            <sCSPolicyIDMoniker name="/QuerySuggest/QuerySuggestGroup/QueryInstances" />
          </setting>
        </map>
      </maps>
      <components>
        <groupHascomponents>
          <role name="Query" generation="1" functional="0" release="0" software="C:\Users\Patrick\Documents\Visual Studio 2013\Projects\QuerySuggest\QuerySuggest\csx\Release\roles\Query" entryPoint="base\x64\WaHostBootstrapper.exe" parameters="base\x64\WaIISHost.exe " memIndex="1792" hostingEnvironment="frontendadmin" hostingEnvironmentVersion="2">
            <componentports>
              <inPort name="Endpoint1" protocol="http" portRanges="80" />
            </componentports>
            <settings>
              <aCS name="Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" defaultValue="" />
              <aCS name="__ModelData" defaultValue="&lt;m role=&quot;Query&quot; xmlns=&quot;urn:azure:m:v1&quot;&gt;&lt;r name=&quot;Query&quot;&gt;&lt;e name=&quot;Endpoint1&quot; /&gt;&lt;/r&gt;&lt;/m&gt;" />
            </settings>
            <resourcereferences>
              <resourceReference name="DiagnosticStore" defaultAmount="[4096,4096,4096]" defaultSticky="true" kind="Directory" />
              <resourceReference name="EventStore" defaultAmount="[1000,1000,1000]" defaultSticky="false" kind="LogStore" />
            </resourcereferences>
          </role>
          <sCSPolicy>
            <sCSPolicyIDMoniker name="/QuerySuggest/QuerySuggestGroup/QueryInstances" />
            <sCSPolicyUpdateDomainMoniker name="/QuerySuggest/QuerySuggestGroup/QueryUpgradeDomains" />
            <sCSPolicyFaultDomainMoniker name="/QuerySuggest/QuerySuggestGroup/QueryFaultDomains" />
          </sCSPolicy>
        </groupHascomponents>
      </components>
      <sCSPolicy>
        <sCSPolicyUpdateDomain name="QueryUpgradeDomains" defaultPolicy="[5,5,5]" />
        <sCSPolicyFaultDomain name="QueryFaultDomains" defaultPolicy="[2,2,2]" />
        <sCSPolicyID name="QueryInstances" defaultPolicy="[1,1,1]" />
      </sCSPolicy>
    </group>
  </groups>
  <implements>
    <implementation Id="6fedceff-1ac0-445f-8e54-04a5465a8794" ref="Microsoft.RedDog.Contract\ServiceContract\QuerySuggestContract@ServiceDefinition">
      <interfacereferences>
        <interfaceReference Id="b7548ca1-6b11-4e37-9e2d-9c6d31966f32" ref="Microsoft.RedDog.Contract\Interface\Query:Endpoint1@ServiceDefinition">
          <inPort>
            <inPortMoniker name="/QuerySuggest/QuerySuggestGroup/Query:Endpoint1" />
          </inPort>
        </interfaceReference>
      </interfacereferences>
    </implementation>
  </implements>
</serviceModel>