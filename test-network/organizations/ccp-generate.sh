#!/bin/bash

function one_line_pem {
    echo "`awk 'NF {sub(/\\n/, ""); printf "%s\\\\\\\n",$0;}' $1`"
}

function json_ccp {
    local PP=$(one_line_pem $4)
    local CP=$(one_line_pem $5)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${P0PORT}/$2/" \
        -e "s/\${P1PORT}/$6/" \
        -e "s/\${CAPORT}/$3/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        organizations/ccp-template.json
}

function yaml_ccp {
    local PP=$(one_line_pem $4)
    local CP=$(one_line_pem $5)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${P0PORT}/$2/" \
        -e "s/\${P1PORT}/$6/" \
        -e "s/\${CAPORT}/$3/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        organizations/ccp-template.yaml | sed -e $'s/\\\\n/\\\n          /g'
}

ORG=1
P0PORT=7051
P1PORT=7151
CAPORT=7054
PEERPEM=organizations/peerOrganizations/farmer.example.com/tlsca/tlsca.farmer.example.com-cert.pem
CAPEM=organizations/peerOrganizations/farmer.example.com/ca/ca.farmer.example.com-cert.pem

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/farmer.example.com/connection-farmer.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/farmer.example.com/connection-farmer.yaml
echo "$(json_ccp $ORG $P1PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/farmer.example.com/connection-farmer.json
echo "$(yaml_ccp $ORG $P1PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/farmer.example.com/connection-farmer.yaml

ORG=2
P0PORT=9051
P1PORT=9151
CAPORT=8054
PEERPEM=organizations/peerOrganizations/wholeseller.example.com/tlsca/tlsca.wholeseller.example.com-cert.pem
CAPEM=organizations/peerOrganizations/wholeseller.example.com/ca/ca.wholeseller.example.com-cert.pem

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/wholeseller.example.com/connection-wholeseller.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/wholeseller.example.com/connection-wholeseller.yaml
echo "$(json_ccp $ORG $P1PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/wholeseller.example.com/connection-wholeseller.json
echo "$(yaml_ccp $ORG $P1PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/wholeseller.example.com/connection-wholeseller.yaml

ORG=3
P0PORT=9251
P1PORT=9351
CAPORT=9054
PEERPEM=organizations/peerOrganizations/distributor.example.com/tlsca/tlsca.distributor.example.com-cert.pem
CAPEM=organizations/peerOrganizations/distributor.example.com/ca/ca.distributor.example.com-cert.pem

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/wholeseller.example.com/connection-wholeseller.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/wholeseller.example.com/connection-wholeseller.yaml
echo "$(json_ccp $ORG $P1PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/wholeseller.example.com/connection-wholeseller.json
echo "$(yaml_ccp $ORG $P1PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/wholeseller.example.com/connection-wholeseller.yaml

ORG=4
P0PORT=9451
P1PORT=9551
CAPORT=8070
PEERPEM=organizations/peerOrganizations/retailor.example.com/tlsca/tlsca.retailor.example.com-cert.pem
CAPEM=organizations/peerOrganizations/retailor.example.com/ca/ca.retailor.example.com-cert.pem

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/retailor.example.com/connection-retailor.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/retailor.example.com/connection-retailor.yaml

echo "$(json_ccp $ORG $P1PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/retailor.example.com/connection-retailor.json
echo "$(yaml_ccp $ORG $P1PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/retailor.example.com/connection-retailor.yaml

ORG=5
P0PORT=9651
P1PORT=9751
CAPORT=9070
PEERPEM=organizations/peerOrganizations/transporter.example.com/tlsca/tlsca.transporter.example.com-cert.pem
CAPEM=organizations/peerOrganizations/transporter.example.com/ca/ca.transporter.example.com-cert.pem

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/transporter.example.com/connection-transporter.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/transporter.example.com/connection-transporter.yaml
echo "$(json_ccp $ORG $P1PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/transporter.example.com/connection-transporter.json
echo "$(yaml_ccp $ORG $P1PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/transporter.example.com/connection-transporter.yaml