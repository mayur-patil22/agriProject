#!/bin/bash

function createFarmer() {
  infoln "Enrolling the CA admin"
  mkdir -p organizations/peerOrganizations/farmer.example.com/

  export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/farmer.example.com/

  set -x
  fabric-ca-client enroll -u https://admin:adminpw@localhost:7054 --caname ca-farmer --tls.certfiles ${PWD}/organizations/fabric-ca/farmer/tls-cert.pem
  { set +x; } 2>/dev/null

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-farmer.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-farmer.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-farmer.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-farmer.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/organizations/peerOrganizations/farmer.example.com/msp/config.yaml

  infoln "Registering peer0"
  set -x
  fabric-ca-client register --caname ca-farmer --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/organizations/fabric-ca/farmer/tls-cert.pem
  { set +x; } 2>/dev/null

  infoln "Registering user"
  set -x
  fabric-ca-client register --caname ca-farmer --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/organizations/fabric-ca/farmer/tls-cert.pem
  { set +x; } 2>/dev/null

  infoln "Registering the org admin"
  set -x
  fabric-ca-client register --caname ca-farmer --id.name farmeradmin --id.secret farmeradminpw --id.type admin --tls.certfiles ${PWD}/organizations/fabric-ca/farmer/tls-cert.pem
  { set +x; } 2>/dev/null

  infoln "Generating the peer0 msp"
  set -x
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:7054 --caname ca-farmer -M ${PWD}/organizations/peerOrganizations/farmer.example.com/peers/peer0.farmer.example.com/msp --csr.hosts peer0.farmer.example.com --tls.certfiles ${PWD}/organizations/fabric-ca/farmer/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/peerOrganizations/farmer.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/farmer.example.com/peers/peer0.farmer.example.com/msp/config.yaml

  infoln "Generating the peer0-tls certificates"
  set -x
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:7054 --caname ca-farmer -M ${PWD}/organizations/peerOrganizations/farmer.example.com/peers/peer0.farmer.example.com/tls --enrollment.profile tls --csr.hosts peer0.farmer.example.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/farmer/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/peerOrganizations/farmer.example.com/peers/peer0.farmer.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/farmer.example.com/peers/peer0.farmer.example.com/tls/ca.crt
  cp ${PWD}/organizations/peerOrganizations/farmer.example.com/peers/peer0.farmer.example.com/tls/signcerts/* ${PWD}/organizations/peerOrganizations/farmer.example.com/peers/peer0.farmer.example.com/tls/server.crt
  cp ${PWD}/organizations/peerOrganizations/farmer.example.com/peers/peer0.farmer.example.com/tls/keystore/* ${PWD}/organizations/peerOrganizations/farmer.example.com/peers/peer0.farmer.example.com/tls/server.key

  mkdir -p ${PWD}/organizations/peerOrganizations/farmer.example.com/msp/tlscacerts
  cp ${PWD}/organizations/peerOrganizations/farmer.example.com/peers/peer0.farmer.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/farmer.example.com/msp/tlscacerts/ca.crt

  mkdir -p ${PWD}/organizations/peerOrganizations/farmer.example.com/tlsca
  cp ${PWD}/organizations/peerOrganizations/farmer.example.com/peers/peer0.farmer.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/farmer.example.com/tlsca/tlsca.farmer.example.com-cert.pem

  mkdir -p ${PWD}/organizations/peerOrganizations/farmer.example.com/ca
  cp ${PWD}/organizations/peerOrganizations/farmer.example.com/peers/peer0.farmer.example.com/msp/cacerts/* ${PWD}/organizations/peerOrganizations/farmer.example.com/ca/ca.farmer.example.com-cert.pem

infoln "Registering peer1"
  set -x
  fabric-ca-client register --caname ca-farmer --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles ${PWD}/organizations/fabric-ca/farmer/tls-cert.pem
  { set +x; } 2>/dev/null

  infoln "Registering user"
  set -x
  fabric-ca-client register --caname ca-farmer --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/organizations/fabric-ca/farmer/tls-cert.pem
  { set +x; } 2>/dev/null

  infoln "Registering the org admin"
  set -x
  fabric-ca-client register --caname ca-farmer --id.name farmeradmin --id.secret farmeradminpw --id.type admin --tls.certfiles ${PWD}/organizations/fabric-ca/farmer/tls-cert.pem
  { set +x; } 2>/dev/null

  infoln "Generating the peer1 msp"
  set -x
  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:7054 --caname ca-farmer -M ${PWD}/organizations/peerOrganizations/farmer.example.com/peers/peer1.farmer.example.com/msp --csr.hosts peer1.farmer.example.com --tls.certfiles ${PWD}/organizations/fabric-ca/farmer/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/peerOrganizations/farmer.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/farmer.example.com/peers/peer1.farmer.example.com/msp/config.yaml

  infoln "Generating the peer1-tls certificates"
  set -x
  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:7054 --caname ca-farmer -M ${PWD}/organizations/peerOrganizations/farmer.example.com/peers/peer1.farmer.example.com/tls --enrollment.profile tls --csr.hosts peer1.farmer.example.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/farmer/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/peerOrganizations/farmer.example.com/peers/peer1.farmer.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/farmer.example.com/peers/peer1.farmer.example.com/tls/ca.crt
  cp ${PWD}/organizations/peerOrganizations/farmer.example.com/peers/peer1.farmer.example.com/tls/signcerts/* ${PWD}/organizations/peerOrganizations/farmer.example.com/peers/peer1.farmer.example.com/tls/server.crt
  cp ${PWD}/organizations/peerOrganizations/farmer.example.com/peers/peer1.farmer.example.com/tls/keystore/* ${PWD}/organizations/peerOrganizations/farmer.example.com/peers/peer1.farmer.example.com/tls/server.key

  mkdir -p ${PWD}/organizations/peerOrganizations/farmer.example.com/msp/tlscacerts
  cp ${PWD}/organizations/peerOrganizations/farmer.example.com/peers/peer1.farmer.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/farmer.example.com/msp/tlscacerts/ca.crt

  mkdir -p ${PWD}/organizations/peerOrganizations/farmer.example.com/tlsca
  cp ${PWD}/organizations/peerOrganizations/farmer.example.com/peers/peer1.farmer.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/farmer.example.com/tlsca/tlsca.farmer.example.com-cert.pem

  mkdir -p ${PWD}/organizations/peerOrganizations/farmer.example.com/ca
  cp ${PWD}/organizations/peerOrganizations/farmer.example.com/peers/peer1.farmer.example.com/msp/cacerts/* ${PWD}/organizations/peerOrganizations/farmer.example.com/ca/ca.farmer.example.com-cert.pem

  infoln "Generating the user msp"
  set -x
  fabric-ca-client enroll -u https://user1:user1pw@localhost:7054 --caname ca-farmer -M ${PWD}/organizations/peerOrganizations/farmer.example.com/users/User1@farmer.example.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/farmer/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/peerOrganizations/farmer.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/farmer.example.com/users/User1@farmer.example.com/msp/config.yaml

  infoln "Generating the org admin msp"
  set -x
  fabric-ca-client enroll -u https://farmeradmin:farmeradminpw@localhost:7054 --caname ca-farmer -M ${PWD}/organizations/peerOrganizations/farmer.example.com/users/Admin@farmer.example.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/farmer/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/peerOrganizations/farmer.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/farmer.example.com/users/Admin@farmer.example.com/msp/config.yaml
}

function createWholeseller() {
  infoln "Enrolling the CA admin"
  mkdir -p organizations/peerOrganizations/wholeseller.example.com/

  export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/wholeseller.example.com/

  set -x
  fabric-ca-client enroll -u https://admin:adminpw@localhost:8054 --caname ca-wholeseller --tls.certfiles ${PWD}/organizations/fabric-ca/wholeseller/tls-cert.pem
  { set +x; } 2>/dev/null

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-wholeseller.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-wholeseller.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-wholeseller.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-wholeseller.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/organizations/peerOrganizations/wholeseller.example.com/msp/config.yaml

  infoln "Registering peer0"
  set -x
  fabric-ca-client register --caname ca-wholeseller --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/organizations/fabric-ca/wholeseller/tls-cert.pem
  { set +x; } 2>/dev/null

  infoln "Registering user"
  set -x
  fabric-ca-client register --caname ca-wholeseller --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/organizations/fabric-ca/wholeseller/tls-cert.pem
  { set +x; } 2>/dev/null

  infoln "Registering the org admin"
  set -x
  fabric-ca-client register --caname ca-wholeseller --id.name wholeselleradmin --id.secret wholeselleradminpw --id.type admin --tls.certfiles ${PWD}/organizations/fabric-ca/wholeseller/tls-cert.pem
  { set +x; } 2>/dev/null

  infoln "Generating the peer0 msp"
  set -x
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:8054 --caname ca-wholeseller -M ${PWD}/organizations/peerOrganizations/wholeseller.example.com/peers/peer0.wholeseller.example.com/msp --csr.hosts peer0.wholeseller.example.com --tls.certfiles ${PWD}/organizations/fabric-ca/wholeseller/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/peerOrganizations/wholeseller.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/wholeseller.example.com/peers/peer0.wholeseller.example.com/msp/config.yaml

  infoln "Generating the peer0-tls certificates"
  set -x
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:8054 --caname ca-wholeseller -M ${PWD}/organizations/peerOrganizations/wholeseller.example.com/peers/peer0.wholeseller.example.com/tls --enrollment.profile tls --csr.hosts peer0.wholeseller.example.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/wholeseller/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/peerOrganizations/wholeseller.example.com/peers/peer0.wholeseller.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/wholeseller.example.com/peers/peer0.wholeseller.example.com/tls/ca.crt
  cp ${PWD}/organizations/peerOrganizations/wholeseller.example.com/peers/peer0.wholeseller.example.com/tls/signcerts/* ${PWD}/organizations/peerOrganizations/wholeseller.example.com/peers/peer0.wholeseller.example.com/tls/server.crt
  cp ${PWD}/organizations/peerOrganizations/wholeseller.example.com/peers/peer0.wholeseller.example.com/tls/keystore/* ${PWD}/organizations/peerOrganizations/wholeseller.example.com/peers/peer0.wholeseller.example.com/tls/server.key

  mkdir -p ${PWD}/organizations/peerOrganizations/wholeseller.example.com/msp/tlscacerts
  cp ${PWD}/organizations/peerOrganizations/wholeseller.example.com/peers/peer0.wholeseller.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/wholeseller.example.com/msp/tlscacerts/ca.crt

  mkdir -p ${PWD}/organizations/peerOrganizations/wholeseller.example.com/tlsca
  cp ${PWD}/organizations/peerOrganizations/wholeseller.example.com/peers/peer0.wholeseller.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/wholeseller.example.com/tlsca/tlsca.wholeseller.example.com-cert.pem

  mkdir -p ${PWD}/organizations/peerOrganizations/wholeseller.example.com/ca
  cp ${PWD}/organizations/peerOrganizations/wholeseller.example.com/peers/peer0.wholeseller.example.com/msp/cacerts/* ${PWD}/organizations/peerOrganizations/wholeseller.example.com/ca/ca.wholeseller.example.com-cert.pem

  infoln "Registering peer1"
  set -x
  fabric-ca-client register --caname ca-wholeseller --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles ${PWD}/organizations/fabric-ca/wholeseller/tls-cert.pem
  { set +x; } 2>/dev/null

  infoln "Registering user"
  set -x
  fabric-ca-client register --caname ca-wholeseller --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/organizations/fabric-ca/wholeseller/tls-cert.pem
  { set +x; } 2>/dev/null

  infoln "Registering the org admin"
  set -x
  fabric-ca-client register --caname ca-wholeseller --id.name wholeselleradmin --id.secret wholeselleradminpw --id.type admin --tls.certfiles ${PWD}/organizations/fabric-ca/wholeseller/tls-cert.pem
  { set +x; } 2>/dev/null

  infoln "Generating the peer1 msp"
  set -x
  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:8054 --caname ca-wholeseller -M ${PWD}/organizations/peerOrganizations/wholeseller.example.com/peers/peer1.wholeseller.example.com/msp --csr.hosts peer1.wholeseller.example.com --tls.certfiles ${PWD}/organizations/fabric-ca/wholeseller/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/peerOrganizations/wholeseller.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/wholeseller.example.com/peers/peer1.wholeseller.example.com/msp/config.yaml

  infoln "Generating the peer1-tls certificates"
  set -x
  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:8054 --caname ca-wholeseller -M ${PWD}/organizations/peerOrganizations/wholeseller.example.com/peers/peer1.wholeseller.example.com/tls --enrollment.profile tls --csr.hosts peer1.wholeseller.example.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/wholeseller/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/peerOrganizations/wholeseller.example.com/peers/peer1.wholeseller.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/wholeseller.example.com/peers/peer1.wholeseller.example.com/tls/ca.crt
  cp ${PWD}/organizations/peerOrganizations/wholeseller.example.com/peers/peer1.wholeseller.example.com/tls/signcerts/* ${PWD}/organizations/peerOrganizations/wholeseller.example.com/peers/peer1.wholeseller.example.com/tls/server.crt
  cp ${PWD}/organizations/peerOrganizations/wholeseller.example.com/peers/peer1.wholeseller.example.com/tls/keystore/* ${PWD}/organizations/peerOrganizations/wholeseller.example.com/peers/peer1.wholeseller.example.com/tls/server.key

  mkdir -p ${PWD}/organizations/peerOrganizations/wholeseller.example.com/msp/tlscacerts
  cp ${PWD}/organizations/peerOrganizations/wholeseller.example.com/peers/peer1.wholeseller.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/wholeseller.example.com/msp/tlscacerts/ca.crt

  mkdir -p ${PWD}/organizations/peerOrganizations/wholeseller.example.com/tlsca
  cp ${PWD}/organizations/peerOrganizations/wholeseller.example.com/peers/peer1.wholeseller.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/wholeseller.example.com/tlsca/tlsca.wholeseller.example.com-cert.pem

  mkdir -p ${PWD}/organizations/peerOrganizations/wholeseller.example.com/ca
  cp ${PWD}/organizations/peerOrganizations/wholeseller.example.com/peers/peer1.wholeseller.example.com/msp/cacerts/* ${PWD}/organizations/peerOrganizations/wholeseller.example.com/ca/ca.wholeseller.example.com-cert.pem

  infoln "Generating the user msp"
  set -x
  fabric-ca-client enroll -u https://user1:user1pw@localhost:8054 --caname ca-wholeseller -M ${PWD}/organizations/peerOrganizations/wholeseller.example.com/users/User1@wholeseller.example.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/wholeseller/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/peerOrganizations/wholeseller.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/wholeseller.example.com/users/User1@wholeseller.example.com/msp/config.yaml

  infoln "Generating the org admin msp"
  set -x
  fabric-ca-client enroll -u https://wholeselleradmin:wholeselleradminpw@localhost:8054 --caname ca-wholeseller -M ${PWD}/organizations/peerOrganizations/wholeseller.example.com/users/Admin@wholeseller.example.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/wholeseller/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/peerOrganizations/wholeseller.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/wholeseller.example.com/users/Admin@wholeseller.example.com/msp/config.yaml
}

function createDistributors() {
  infoln "Enrolling the CA admin"
  mkdir -p organizations/peerOrganizations/distributors.example.com/

  export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/distributors.example.com/

  set -x
  fabric-ca-client enroll -u https://admin:adminpw@localhost:9054 --caname ca-distributors --tls.certfiles ${PWD}/organizations/fabric-ca/distributors/tls-cert.pem
  { set +x; } 2>/dev/null

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-distributors.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-distributors.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-distributors.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-distributors.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/organizations/peerOrganizations/distributors.example.com/msp/config.yaml

  infoln "Registering peer0"
  set -x
  fabric-ca-client register --caname ca-distributors --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/organizations/fabric-ca/distributors/tls-cert.pem
  { set +x; } 2>/dev/null

  infoln "Registering user"
  set -x
  fabric-ca-client register --caname ca-distributors --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/organizations/fabric-ca/distributors/tls-cert.pem
  { set +x; } 2>/dev/null

  infoln "Registering the org admin"
  set -x
  fabric-ca-client register --caname ca-distributors --id.name distributorsadmin --id.secret distributorsadminpw --id.type admin --tls.certfiles ${PWD}/organizations/fabric-ca/distributors/tls-cert.pem
  { set +x; } 2>/dev/null

  infoln "Generating the peer0 msp"
  set -x
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:9054 --caname ca-distributors -M ${PWD}/organizations/peerOrganizations/distributors.example.com/peers/peer0.distributors.example.com/msp --csr.hosts peer0.distributors.example.com --tls.certfiles ${PWD}/organizations/fabric-ca/distributors/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/peerOrganizations/distributors.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/distributors.example.com/peers/peer0.distributors.example.com/msp/config.yaml

  infoln "Generating the peer0-tls certificates"
  set -x
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:9054 --caname ca-distributors -M ${PWD}/organizations/peerOrganizations/distributors.example.com/peers/peer0.distributors.example.com/tls --enrollment.profile tls --csr.hosts peer0.distributors.example.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/distributors/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/peerOrganizations/distributors.example.com/peers/peer0.distributors.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/distributors.example.com/peers/peer0.distributors.example.com/tls/ca.crt
  cp ${PWD}/organizations/peerOrganizations/distributors.example.com/peers/peer0.distributors.example.com/tls/signcerts/* ${PWD}/organizations/peerOrganizations/distributors.example.com/peers/peer0.distributors.example.com/tls/server.crt
  cp ${PWD}/organizations/peerOrganizations/distributors.example.com/peers/peer0.distributors.example.com/tls/keystore/* ${PWD}/organizations/peerOrganizations/distributors.example.com/peers/peer0.distributors.example.com/tls/server.key

  mkdir -p ${PWD}/organizations/peerOrganizations/distributors.example.com/msp/tlscacerts
  cp ${PWD}/organizations/peerOrganizations/distributors.example.com/peers/peer0.distributors.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/distributors.example.com/msp/tlscacerts/ca.crt

  mkdir -p ${PWD}/organizations/peerOrganizations/distributors.example.com/tlsca
  cp ${PWD}/organizations/peerOrganizations/distributors.example.com/peers/peer0.distributors.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/distributors.example.com/tlsca/tlsca.distributors.example.com-cert.pem

  mkdir -p ${PWD}/organizations/peerOrganizations/distributors.example.com/ca
  cp ${PWD}/organizations/peerOrganizations/distributors.example.com/peers/peer0.distributors.example.com/msp/cacerts/* ${PWD}/organizations/peerOrganizations/distributors.example.com/ca/ca.distributors.example.com-cert.pem

infoln "Registering peer1"
  set -x
  fabric-ca-client register --caname ca-distributors --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles ${PWD}/organizations/fabric-ca/distributors/tls-cert.pem
  { set +x; } 2>/dev/null

  infoln "Registering user"
  set -x
  fabric-ca-client register --caname ca-distributors --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/organizations/fabric-ca/distributors/tls-cert.pem
  { set +x; } 2>/dev/null

  infoln "Registering the org admin"
  set -x
  fabric-ca-client register --caname ca-distributors --id.name distributorsadmin --id.secret distributorsadminpw --id.type admin --tls.certfiles ${PWD}/organizations/fabric-ca/distributors/tls-cert.pem
  { set +x; } 2>/dev/null

  infoln "Generating the peer1 msp"
  set -x
  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:9054 --caname ca-distributors -M ${PWD}/organizations/peerOrganizations/distributors.example.com/peers/peer1.distributors.example.com/msp --csr.hosts peer1.distributors.example.com --tls.certfiles ${PWD}/organizations/fabric-ca/distributors/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/peerOrganizations/distributors.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/distributors.example.com/peers/peer1.distributors.example.com/msp/config.yaml

  infoln "Generating the peer1-tls certificates"
  set -x
  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:9054 --caname ca-distributors -M ${PWD}/organizations/peerOrganizations/distributors.example.com/peers/peer1.distributors.example.com/tls --enrollment.profile tls --csr.hosts peer1.distributors.example.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/distributors/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/peerOrganizations/distributors.example.com/peers/peer1.distributors.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/distributors.example.com/peers/peer1.distributors.example.com/tls/ca.crt
  cp ${PWD}/organizations/peerOrganizations/distributors.example.com/peers/peer1.distributors.example.com/tls/signcerts/* ${PWD}/organizations/peerOrganizations/distributors.example.com/peers/peer1.distributors.example.com/tls/server.crt
  cp ${PWD}/organizations/peerOrganizations/distributors.example.com/peers/peer1.distributors.example.com/tls/keystore/* ${PWD}/organizations/peerOrganizations/distributors.example.com/peers/peer1.distributors.example.com/tls/server.key

  mkdir -p ${PWD}/organizations/peerOrganizations/distributors.example.com/msp/tlscacerts
  cp ${PWD}/organizations/peerOrganizations/distributors.example.com/peers/peer1.distributors.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/distributors.example.com/msp/tlscacerts/ca.crt

  mkdir -p ${PWD}/organizations/peerOrganizations/distributors.example.com/tlsca
  cp ${PWD}/organizations/peerOrganizations/distributors.example.com/peers/peer1.distributors.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/distributors.example.com/tlsca/tlsca.distributors.example.com-cert.pem

  mkdir -p ${PWD}/organizations/peerOrganizations/distributors.example.com/ca
  cp ${PWD}/organizations/peerOrganizations/distributors.example.com/peers/peer1.distributors.example.com/msp/cacerts/* ${PWD}/organizations/peerOrganizations/distributors.example.com/ca/ca.distributors.example.com-cert.pem

  infoln "Generating the user msp"
  set -x
  fabric-ca-client enroll -u https://user1:user1pw@localhost:9054 --caname ca-distributors -M ${PWD}/organizations/peerOrganizations/distributors.example.com/users/User1@distributors.example.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/distributors/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/peerOrganizations/distributors.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/distributors.example.com/users/User1@distributors.example.com/msp/config.yaml

  infoln "Generating the org admin msp"
  set -x
  fabric-ca-client enroll -u https://distributorsadmin:distributorsadminpw@localhost:9054 --caname ca-distributors -M ${PWD}/organizations/peerOrganizations/distributors.example.com/users/Admin@distributors.example.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/distributors/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/peerOrganizations/distributors.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/distributors.example.com/users/Admin@distributors.example.com/msp/config.yaml
}

function createRetailers() {
  infoln "Enrolling the CA admin"
  mkdir -p organizations/peerOrganizations/retailers.example.com/

  export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/retailers.example.com/

  set -x
  fabric-ca-client enroll -u https://admin:adminpw@localhost:8070 --caname ca-retailers --tls.certfiles ${PWD}/organizations/fabric-ca/retailers/tls-cert.pem
  { set +x; } 2>/dev/null

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-8070-ca-retailers.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-8070-ca-retailers.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-8070-ca-retailers.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-8070-ca-retailers.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/organizations/peerOrganizations/retailers.example.com/msp/config.yaml

  infoln "Registering peer0"
  set -x
  fabric-ca-client register --caname ca-retailers --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/organizations/fabric-ca/retailers/tls-cert.pem
  { set +x; } 2>/dev/null

  infoln "Registering user"
  set -x
  fabric-ca-client register --caname ca-retailers --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/organizations/fabric-ca/retailers/tls-cert.pem
  { set +x; } 2>/dev/null

  infoln "Registering the org admin"
  set -x
  fabric-ca-client register --caname ca-retailers --id.name retailersadmin --id.secret retailersadminpw --id.type admin --tls.certfiles ${PWD}/organizations/fabric-ca/retailers/tls-cert.pem
  { set +x; } 2>/dev/null

  infoln "Generating the peer0 msp"
  set -x
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:8070 --caname ca-retailers -M ${PWD}/organizations/peerOrganizations/retailers.example.com/peers/peer0.retailers.example.com/msp --csr.hosts peer0.retailers.example.com --tls.certfiles ${PWD}/organizations/fabric-ca/retailers/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/peerOrganizations/retailers.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/retailers.example.com/peers/peer0.retailers.example.com/msp/config.yaml

  infoln "Generating the peer0-tls certificates"
  set -x
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:8070 --caname ca-retailers -M ${PWD}/organizations/peerOrganizations/retailers.example.com/peers/peer0.retailers.example.com/tls --enrollment.profile tls --csr.hosts peer0.retailers.example.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/retailers/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/peerOrganizations/retailers.example.com/peers/peer0.retailers.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/retailers.example.com/peers/peer0.retailers.example.com/tls/ca.crt
  cp ${PWD}/organizations/peerOrganizations/retailers.example.com/peers/peer0.retailers.example.com/tls/signcerts/* ${PWD}/organizations/peerOrganizations/retailers.example.com/peers/peer0.retailers.example.com/tls/server.crt
  cp ${PWD}/organizations/peerOrganizations/retailers.example.com/peers/peer0.retailers.example.com/tls/keystore/* ${PWD}/organizations/peerOrganizations/retailers.example.com/peers/peer0.retailers.example.com/tls/server.key

  mkdir -p ${PWD}/organizations/peerOrganizations/retailers.example.com/msp/tlscacerts
  cp ${PWD}/organizations/peerOrganizations/retailers.example.com/peers/peer0.retailers.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/retailers.example.com/msp/tlscacerts/ca.crt

  mkdir -p ${PWD}/organizations/peerOrganizations/retailers.example.com/tlsca
  cp ${PWD}/organizations/peerOrganizations/retailers.example.com/peers/peer0.retailers.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/retailers.example.com/tlsca/tlsca.retailers.example.com-cert.pem

  mkdir -p ${PWD}/organizations/peerOrganizations/retailers.example.com/ca
  cp ${PWD}/organizations/peerOrganizations/retailers.example.com/peers/peer0.retailers.example.com/msp/cacerts/* ${PWD}/organizations/peerOrganizations/retailers.example.com/ca/ca.retailers.example.com-cert.pem

 infoln "Registering peer1"
  set -x
  fabric-ca-client register --caname ca-retailers --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles ${PWD}/organizations/fabric-ca/retailers/tls-cert.pem
  { set +x; } 2>/dev/null

  infoln "Registering user"
  set -x
  fabric-ca-client register --caname ca-retailers --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/organizations/fabric-ca/retailers/tls-cert.pem
  { set +x; } 2>/dev/null

  infoln "Registering the org admin"
  set -x
  fabric-ca-client register --caname ca-retailers --id.name retailersadmin --id.secret retailersadminpw --id.type admin --tls.certfiles ${PWD}/organizations/fabric-ca/retailers/tls-cert.pem
  { set +x; } 2>/dev/null

  infoln "Generating the peer1 msp"
  set -x
  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:8070 --caname ca-retailers -M ${PWD}/organizations/peerOrganizations/retailers.example.com/peers/peer1.retailers.example.com/msp --csr.hosts peer1.retailers.example.com --tls.certfiles ${PWD}/organizations/fabric-ca/retailers/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/peerOrganizations/retailers.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/retailers.example.com/peers/peer1.retailers.example.com/msp/config.yaml

  infoln "Generating the peer1-tls certificates"
  set -x
  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:8070 --caname ca-retailers -M ${PWD}/organizations/peerOrganizations/retailers.example.com/peers/peer1.retailers.example.com/tls --enrollment.profile tls --csr.hosts peer1.retailers.example.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/retailers/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/peerOrganizations/retailers.example.com/peers/peer1.retailers.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/retailers.example.com/peers/peer1.retailers.example.com/tls/ca.crt
  cp ${PWD}/organizations/peerOrganizations/retailers.example.com/peers/peer1.retailers.example.com/tls/signcerts/* ${PWD}/organizations/peerOrganizations/retailers.example.com/peers/peer1.retailers.example.com/tls/server.crt
  cp ${PWD}/organizations/peerOrganizations/retailers.example.com/peers/peer1.retailers.example.com/tls/keystore/* ${PWD}/organizations/peerOrganizations/retailers.example.com/peers/peer1.retailers.example.com/tls/server.key

  mkdir -p ${PWD}/organizations/peerOrganizations/retailers.example.com/msp/tlscacerts
  cp ${PWD}/organizations/peerOrganizations/retailers.example.com/peers/peer1.retailers.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/retailers.example.com/msp/tlscacerts/ca.crt

  mkdir -p ${PWD}/organizations/peerOrganizations/retailers.example.com/tlsca
  cp ${PWD}/organizations/peerOrganizations/retailers.example.com/peers/peer1.retailers.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/retailers.example.com/tlsca/tlsca.retailers.example.com-cert.pem

  mkdir -p ${PWD}/organizations/peerOrganizations/retailers.example.com/ca
  cp ${PWD}/organizations/peerOrganizations/retailers.example.com/peers/peer1.retailers.example.com/msp/cacerts/* ${PWD}/organizations/peerOrganizations/retailers.example.com/ca/ca.retailers.example.com-cert.pem

  infoln "Generating the user msp"
  set -x
  fabric-ca-client enroll -u https://user1:user1pw@localhost:8070 --caname ca-retailers -M ${PWD}/organizations/peerOrganizations/retailers.example.com/users/User1@retailers.example.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/retailers/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/peerOrganizations/retailers.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/retailers.example.com/users/User1@retailers.example.com/msp/config.yaml

  infoln "Generating the org admin msp"
  set -x
  fabric-ca-client enroll -u https://retailersadmin:retailersadminpw@localhost:8070 --caname ca-retailers -M ${PWD}/organizations/peerOrganizations/retailers.example.com/users/Admin@retailers.example.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/retailers/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/peerOrganizations/retailers.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/retailers.example.com/users/Admin@retailers.example.com/msp/config.yaml
}

function createTransporters() {
  infoln "Enrolling the CA admin"
  mkdir -p organizations/peerOrganizations/transporters.example.com/

  export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/transporters.example.com/

  set -x
  fabric-ca-client enroll -u https://admin:adminpw@localhost:9070 --caname ca-transporters --tls.certfiles ${PWD}/organizations/fabric-ca/transporters/tls-cert.pem
  { set +x; } 2>/dev/null

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-9070-ca-transporters.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-9070-ca-transporters.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-9070-ca-transporters.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-9070-ca-transporters.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/organizations/peerOrganizations/transporters.example.com/msp/config.yaml

  infoln "Registering peer0"
  set -x
  fabric-ca-client register --caname ca-transporters --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/organizations/fabric-ca/transporters/tls-cert.pem
  { set +x; } 2>/dev/null

  infoln "Registering user"
  set -x
  fabric-ca-client register --caname ca-transporters --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/organizations/fabric-ca/transporters/tls-cert.pem
  { set +x; } 2>/dev/null

  infoln "Registering the org admin"
  set -x
  fabric-ca-client register --caname ca-transporters --id.name transportersadmin --id.secret transportersadminpw --id.type admin --tls.certfiles ${PWD}/organizations/fabric-ca/transporters/tls-cert.pem
  { set +x; } 2>/dev/null

  infoln "Generating the peer0 msp"
  set -x
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:9070 --caname ca-transporters -M ${PWD}/organizations/peerOrganizations/transporters.example.com/peers/peer0.transporters.example.com/msp --csr.hosts peer0.transporters.example.com --tls.certfiles ${PWD}/organizations/fabric-ca/transporters/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/peerOrganizations/transporters.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/transporters.example.com/peers/peer0.transporters.example.com/msp/config.yaml

  infoln "Generating the peer0-tls certificates"
  set -x
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:9070 --caname ca-transporters -M ${PWD}/organizations/peerOrganizations/transporters.example.com/peers/peer0.transporters.example.com/tls --enrollment.profile tls --csr.hosts peer0.transporters.example.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/transporters/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/peerOrganizations/transporters.example.com/peers/peer0.transporters.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/transporters.example.com/peers/peer0.transporters.example.com/tls/ca.crt
  cp ${PWD}/organizations/peerOrganizations/transporters.example.com/peers/peer0.transporters.example.com/tls/signcerts/* ${PWD}/organizations/peerOrganizations/transporters.example.com/peers/peer0.transporters.example.com/tls/server.crt
  cp ${PWD}/organizations/peerOrganizations/transporters.example.com/peers/peer0.transporters.example.com/tls/keystore/* ${PWD}/organizations/peerOrganizations/transporters.example.com/peers/peer0.transporters.example.com/tls/server.key

  mkdir -p ${PWD}/organizations/peerOrganizations/transporters.example.com/msp/tlscacerts
  cp ${PWD}/organizations/peerOrganizations/transporters.example.com/peers/peer0.transporters.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/transporters.example.com/msp/tlscacerts/ca.crt

  mkdir -p ${PWD}/organizations/peerOrganizations/transporters.example.com/tlsca
  cp ${PWD}/organizations/peerOrganizations/transporters.example.com/peers/peer0.transporters.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/transporters.example.com/tlsca/tlsca.transporters.example.com-cert.pem

  mkdir -p ${PWD}/organizations/peerOrganizations/transporters.example.com/ca
  cp ${PWD}/organizations/peerOrganizations/transporters.example.com/peers/peer0.transporters.example.com/msp/cacerts/* ${PWD}/organizations/peerOrganizations/transporters.example.com/ca/ca.transporters.example.com-cert.pem

infoln "Registering peer1"
  set -x
  fabric-ca-client register --caname ca-transporters --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles ${PWD}/organizations/fabric-ca/transporters/tls-cert.pem
  { set +x; } 2>/dev/null

  infoln "Registering user"
  set -x
  fabric-ca-client register --caname ca-transporters --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/organizations/fabric-ca/transporters/tls-cert.pem
  { set +x; } 2>/dev/null

  infoln "Registering the org admin"
  set -x
  fabric-ca-client register --caname ca-transporters --id.name transportersadmin --id.secret transportersadminpw --id.type admin --tls.certfiles ${PWD}/organizations/fabric-ca/transporters/tls-cert.pem
  { set +x; } 2>/dev/null

  infoln "Generating the peer1 msp"
  set -x
  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:9070 --caname ca-transporters -M ${PWD}/organizations/peerOrganizations/transporters.example.com/peers/peer1.transporters.example.com/msp --csr.hosts peer1.transporters.example.com --tls.certfiles ${PWD}/organizations/fabric-ca/transporters/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/peerOrganizations/transporters.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/transporters.example.com/peers/peer1.transporters.example.com/msp/config.yaml

  infoln "Generating the peer1-tls certificates"
  set -x
  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:9070 --caname ca-transporters -M ${PWD}/organizations/peerOrganizations/transporters.example.com/peers/peer1.transporters.example.com/tls --enrollment.profile tls --csr.hosts peer1.transporters.example.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/transporters/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/peerOrganizations/transporters.example.com/peers/peer1.transporters.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/transporters.example.com/peers/peer1.transporters.example.com/tls/ca.crt
  cp ${PWD}/organizations/peerOrganizations/transporters.example.com/peers/peer1.transporters.example.com/tls/signcerts/* ${PWD}/organizations/peerOrganizations/transporters.example.com/peers/peer1.transporters.example.com/tls/server.crt
  cp ${PWD}/organizations/peerOrganizations/transporters.example.com/peers/peer1.transporters.example.com/tls/keystore/* ${PWD}/organizations/peerOrganizations/transporters.example.com/peers/peer1.transporters.example.com/tls/server.key

  mkdir -p ${PWD}/organizations/peerOrganizations/transporters.example.com/msp/tlscacerts
  cp ${PWD}/organizations/peerOrganizations/transporters.example.com/peers/peer1.transporters.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/transporters.example.com/msp/tlscacerts/ca.crt

  mkdir -p ${PWD}/organizations/peerOrganizations/transporters.example.com/tlsca
  cp ${PWD}/organizations/peerOrganizations/transporters.example.com/peers/peer1.transporters.example.com/tls/tlscacerts/* ${PWD}/organizations/peerOrganizations/transporters.example.com/tlsca/tlsca.transporters.example.com-cert.pem

  mkdir -p ${PWD}/organizations/peerOrganizations/transporters.example.com/ca
  cp ${PWD}/organizations/peerOrganizations/transporters.example.com/peers/peer1.transporters.example.com/msp/cacerts/* ${PWD}/organizations/peerOrganizations/transporters.example.com/ca/ca.transporters.example.com-cert.pem

  infoln "Generating the user msp"
  set -x
  fabric-ca-client enroll -u https://user1:user1pw@localhost:9070 --caname ca-transporters -M ${PWD}/organizations/peerOrganizations/transporters.example.com/users/User1@transporters.example.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/transporters/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/peerOrganizations/transporters.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/transporters.example.com/users/User1@transporters.example.com/msp/config.yaml

  infoln "Generating the org admin msp"
  set -x
  fabric-ca-client enroll -u https://transportersadmin:transportersadminpw@localhost:9070 --caname ca-transporters -M ${PWD}/organizations/peerOrganizations/transporters.example.com/users/Admin@transporters.example.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/transporters/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/peerOrganizations/transporters.example.com/msp/config.yaml ${PWD}/organizations/peerOrganizations/transporters.example.com/users/Admin@transporters.example.com/msp/config.yaml
}


function createOrderer() {
  infoln "Enrolling the CA admin"
  mkdir -p organizations/ordererOrganizations/example.com

  export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/ordererOrganizations/example.com

  set -x
  fabric-ca-client enroll -u https://admin:adminpw@localhost:9054 --caname ca-orderer --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem
  { set +x; } 2>/dev/null

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/organizations/ordererOrganizations/example.com/msp/config.yaml

  infoln "Registering orderer"
  set -x
  fabric-ca-client register --caname ca-orderer --id.name orderer --id.secret ordererpw --id.type orderer --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem
  { set +x; } 2>/dev/null

  infoln "Registering the orderer admin"
  set -x
  fabric-ca-client register --caname ca-orderer --id.name ordererAdmin --id.secret ordererAdminpw --id.type admin --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem
  { set +x; } 2>/dev/null

  infoln "Generating the orderer msp"
  set -x
  fabric-ca-client enroll -u https://orderer:ordererpw@localhost:9054 --caname ca-orderer -M ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp --csr.hosts orderer.example.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/ordererOrganizations/example.com/msp/config.yaml ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/config.yaml

  infoln "Generating the orderer-tls certificates"
  set -x
  fabric-ca-client enroll -u https://orderer:ordererpw@localhost:9054 --caname ca-orderer -M ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls --enrollment.profile tls --csr.hosts orderer.example.com --csr.hosts localhost --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/tlscacerts/* ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/ca.crt
  cp ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/signcerts/* ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/server.crt
  cp ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/keystore/* ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/server.key

  mkdir -p ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts
  cp ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/tlscacerts/* ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

  mkdir -p ${PWD}/organizations/ordererOrganizations/example.com/msp/tlscacerts
  cp ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/tlscacerts/* ${PWD}/organizations/ordererOrganizations/example.com/msp/tlscacerts/tlsca.example.com-cert.pem

  infoln "Generating the admin msp"
  set -x
  fabric-ca-client enroll -u https://ordererAdmin:ordererAdminpw@localhost:9054 --caname ca-orderer -M ${PWD}/organizations/ordererOrganizations/example.com/users/Admin@example.com/msp --tls.certfiles ${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem
  { set +x; } 2>/dev/null

  cp ${PWD}/organizations/ordererOrganizations/example.com/msp/config.yaml ${PWD}/organizations/ordererOrganizations/example.com/users/Admin@example.com/msp/config.yaml
}
