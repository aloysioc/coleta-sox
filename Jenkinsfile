@Library('shared@new')
import ansible.helper.*
import helper.*
import vivoNow.*

def ansible_helper = new ansible.helper()
def vivoNow = new vivoNow()

// stage("🏗️ Parameters Build #${BUILD_NUMBER}") {
//   println('CHG=' + CHG);   if (CHG == '')   { error('CHG vazio!') }
//   println('Edition=' + Edition);   if (Edition == '')   { error('Edition vazia!') }
//   println('array_ip=' + array_ip);   if (array_ip == '')   { error('array_ip vazio!') }
//   println('partD=' + partD);   if (partD == '')   { error('partD vazia!') }
//   println('partL=' + partL);   if (partL == '')   { error('partL vazia!') }
//   println('partT=' + partT);   if (partT == '')   { error('partT vazia!') }
// }
// def nonProdServers = []
// def prodServers = []
def host_serverArray = array_ip.split(',')

if (local_os =~ /Windows*/) { //WINDOWS
    node('jenkins-agent-pod') {
        startTimeTT = sh ( script: "date +%F-%T", returnStdout: true )
        stage("${startTimeTT}") {
            println(startTimeTT)
        }
        stage('git clone') {
            workdir = "$WORKSPACE/$BUILD_TAG"
            sh "mkdir -p ${workdir}"
            dir("${workdir}"){
                git(  //FAZ O CLONE DO PROJETO COM TODOS OS ARQUIVOS NECESSÁRIOS NA MÁQUINA DO JENKINS
                    url: 'http://10.240.42.99:9080/automacao/sistemas_operacionais/coleta-sox-teste/coleta-sox-ansible.git',
                    credentialsId: 'jenkins',
                    branch: "master"
                )
            }
        }
        stage('Inventory WINDOWS'){
            script{
                withCredentials([usernamePassword(credentialsId: 'svc_jenkins', usernameVariable: 'AUSER', passwordVariable: 'APASS')])
                {
                    // CRIANDO O INVENTARIO PARA O ANSIBLE
                    sh "echo '' > ${workdir}/inventory"
                    ansible_helper.createInventory(host_serverArray.join(','),"${workdir}",'install')
                    sh """
                        echo '[all:vars]' >> ${workdir}/inventory
                        echo 'ansible_port=5985' >> ${workdir}/inventory
                        echo 'ansible_connection=winrm' >> ${workdir}/inventory
                        echo 'ansible_winrm_scheme=http' >> ${workdir}/inventory
                        echo 'ansible_winrm_transport=ntlm' >> ${workdir}/inventory
                        echo 'ansible_user=${AUSER}' >> ${workdir}/inventory
                        echo 'ansible_password=${APASS}' >> ${workdir}/inventory
                    """
                    sh "cat ${workdir}/inventory"
                }
            }
        }
        // stage('Ansible Win_Ping Test') {
        //     script {
        //         def result = sh(script: "ansible -i ${workdir}/inventory install -m win_ping", returnStatus: true)
        //         if (result != 0) {
        //             error("Ansible win_ping test failed.")
        //         }
        //     }
        // }
        stage('🔨 Coleta SOX'){
            //EXECUTA O PLAYBOOK DO ANSIBLE
            try {
                withCredentials([usernamePassword(credentialsId: 'svc_jenkins', usernameVariable: 'AUSER', passwordVariable: 'APASS')]) {
                    ansiblePlaybook(
                        disableHostKeyChecking: true,
                        inventory: "${workdir}/inventory",
                        limit: 'install',
                        credentialsId: 'svc_jenkins',
                        playbook: "${workdir}/playbooks/coleta-win-sox.yml",
                        installation: 'ansible_latest',
                        extras: "-e USERNAME=${AUSER} -e PASSWD='${APASS}' -vv",
                        // extras: "-e RITM=${RITM} -e currentDate=${currentDate} -vv",
                        colorized: true
                    ) 
                }
            } catch (Exception err) {
                echo "Erro no Playbook do Ansible. Abortando a build..."
                throw err
            }
        }
    }
} else { //LINUX
    node('jenkins-agent-pod') {
        startTimeTT = sh ( script: "date +%F-%T", returnStdout: true )
        stage("${startTimeTT}") {
            println(startTimeTT)
        }
        stage('git clone') {
            workdir = "$WORKSPACE/$BUILD_TAG"
            sh "mkdir -p ${workdir}"
            dir("${workdir}"){
                git(  //FAZ O CLONE DO PROJETO COM TODOS OS ARQUIVOS NECESSÁRIOS NA MÁQUINA DO JENKINS
                    url: 'http://10.240.42.99:9080/automacao/sistemas_operacionais/coleta-sox-teste/coleta-sox-ansible.git',
                    credentialsId: 'jenkins',
                    branch: "new"
                )
            }
        }
        stage ('Define Array'){
            env.iparray=0
            iparray = array_ip.split(",")
            env.size = iparray.length
            size = size as Integer
            size = size - 1
            arraytotal = []
            for (i in iparray){
                arraytotal.add(i.toString())
            }
            println "Array gerado com sucesso."
            //println size
        }
        stage ("Coleta Infos") {
            def array_string = arraytotal.join(",")
            ansible_helper.createInventory(array_string,workdir,"unix")//CRIAÇÃO DO INVENTÁRIO DO ANSIBLE (SERVIDORES LINUX)

            echo "DIRETORIO DE OUTPUT: http://10.240.42.97:8080/job/$JOB_BASE_NAME/$BUILD_NUMBER/execution/node/3/ws/jenkins-$JOB_BASE_NAME-$BUILD_NUMBER/output"

            sh '> /root/.ssh/known_hosts | true'
            ansiblePlaybook(
                forks: 50,
                disableHostKeyChecking: true,
                inventory: "${workdir}/inventory",
                limit: 'unix',
                credentialsId: 'automata',
                playbook: "${workdir}/playbooks/coleta-info.yml",
                colorized: true,
                extras: ' -v'
                //     export_options_selo_unix: "${params.export_options_selo_unix}",
                //     export_options_checklist_unix: "${params.export_options_checklist_unix}",
                //     export_options_sox_unix: "${params.export_options_sox_unix}",
                //     export_options_selo_windows: "${params.export_options_selo_windows}",
                //     export_options_checklist_windows: "${params.export_options_checklist_windows}",
                //     export_options_sox_windows: "${params.export_options_sox_windows}"                    
                // ]
            ) 
        }
    }        
}    