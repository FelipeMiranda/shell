#!/usr/bin/env ruby

require 'hp_service_manager_uol'
require 'logger'
require 'pry'

sm = HPServiceManagerUOL.new(
  username: 'svcacc_sm_api_ecom',
  password: '7r&wRumA',
  environment: :production_system,
  #logger: Logger.new(STDOUT),
)
date = Time.now
puts date
#CSV.open("/home/wbatista/Compartilhado/ecommerce-#{date}", "wb", col_sep: ";") do |csv|
  pools = []
  ARGV.each do |ci|
# sm.configuration_item.where('assignment = "ecommerce" and istatus = "producao" and (subtype = "hostname" or subtype = "hostnamevm")').each do |ci|
# sm.configuration_item.where("assignment=\"alta audiência\" and istatus = 'producao' and (subtype = 'hostname' or subtype = 'hostnamevm')").each do |ci|

sm.configuration_item_relationship.where("logical.name = \"#{ci}\" and uol.subtype.parent = \"servidores\"").each do |servidores|
  pool = servidores['ParentConfigurationItem']
  tipo = servidores['uol.subtype.logical.name']
case tipo
when "hostname"
tipo = "Fisico"
when "hostnamevm"
tipo = "Virtual"
else
tipo = "Erro na coleta do tipo"
end
  sm.configuration_item_relationship.where("logical.name = \"#{pool}\" and uol.subtype.parent = \"so\"").each do |operacional|
    so = operacional['ParentConfigurationItem']

  sm.configuration_item_relationship.where("logical.name = \"#{pool}\" and uol.subtype.parent = \"componente\"").each do |componente|
    compo = componente['ParentConfigurationItem']

    sm.configuration_item_relationship.where("logical.name = \"#{compo}\" and uol.subtype.parent = \"sistema\"").each do |sistema|
      sis = sistema['ParentConfigurationItem']

      sm.configuration_item_relationship.where("logical.name = \"#{sis}\" and uol.subtype.parent = \"servico\"").each do |servico|
        serv = servico['ParentConfigurationItem']

        sm.configuration_item_relationship.where("logical.name = \"#{serv}\" and (uol.subtype.parent = \"produto\" or uol.subtype.parent = \"produto 1\")").each do |produto|
          type = produto['uol.subtype.parent']
         if type == "produto 1"
            prod1 = produto['ParentConfigurationItem']

            sm.configuration_item_relationship.where("logical.name = \"#{prod1}\" and uol.subtype.parent = \"produto\"").each do |produto|
              prod = produto['ParentConfigurationItem']

              sm.configuration_item_relationship.where("logical.name = \"#{prod}\" and uol.subtype.parent = \"unidade de negocio\"").each do |unidade|
                unit = unidade['ParentConfigurationItem']
#                csv << ["#{pool}", "#{ci}", "#{tipo}", "#{so}", "#{compo}", "#{sis}", "#{serv}", "#{prod1}", "#{prod}", "#{unit}"]
puts "#{pool} #{ci} #{tipo} #{so} #{compo} #{sis} #{serv} #{prod} #{unit}"
#puts "#{pool} #{ci} #{so} @@ #{serv} #{prod} @@ "

              end
            end

          else
            prod = produto['ParentConfigurationItem']
            sm.configuration_item_relationship.where("logical.name = \"#{prod}\" and uol.subtype.parent = \"unidade de negocio\"").each do |unidade|
              unit = unidade['ParentConfigurationItem']
#             csv << ["#{pool}", "#{ci}", "#{tipo}", "#{so}", "#{compo}", "#{sis}", "#{serv}", "N/A", "#{prod}", "#{unit}"]
puts "#{pool} #{ci} #{tipo} #{so} #{compo} #{sis} #{serv} #{prod} #{unit}"
#puts "#{pool} #{ci} #{so} @@ #{sis} #{prod} @@ "
#puts "#{pool} #{ci} - SERVIÇO: #{serv}"
#puts "#{pool} #{ci} - PRODUTO: #{prod}"

#            end
          end
        end
      end
    end
  end
end
end
end
end







