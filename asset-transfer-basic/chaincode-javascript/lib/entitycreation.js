'use strict';

const { Contract } = require('fabric-contract-api');

class AssetTransfer extends Contract {
    async InitLedger(ctx) {
        const assets = [
            {
                farmerID : "12345",
                farmerName : "John Doe",
                location : "Texas",
                role : "farmer",
                cropName : "Wheat",
                batchID : "Batch1",
                harvestDate : "2022-01-01",
                apprxExpiryDate : "2022-05-01",
                status : "TRANSFERRED",
                buyerID : "buyer1",
                sellerID : "seller1",
                retailerID : "retailer1",
                transporterID : "transporter1",

            }
        ];
        for (const asset of assets) {
            asset.docType = 'asset';
            await ctx.stub.putState(asset.ID, Buffer.from(JSON.stringify(asset)));
            console.info(`Asset ${asset.ID} initialized`);
        }
    }
async registerEntity(ctx, farmerID, farmerName, location, role) {
    const entityKey = ctx.stub.createCompositeKey('entity', [farmerID, role]);
    const entity = {
        farmerID,
        farmerName,
        location,
        role
    };

    await ctx.stub.putState(entityKey, Buffer.from(JSON.stringify(entity)));
}

async addBatch(ctx, cropName, batchID, harvestDate, apprxExpiryDate, farmerID) {
    const batchKey = ctx.stub.createCompositeKey('batch', [cropName, batchID]);
    const batch = {
        cropName,
        batchID,
        harvestDate,
        apprxExpiryDate,
        farmerID,
        status: 'IN_TRANSIT'
    };

    await ctx.stub.putState(batchKey, Buffer.from(JSON.stringify(batch)));
}

async transferBatch(ctx, buyerID, sellerID, cropName, batchID, role) {
    const batchKey = ctx.stub.createCompositeKey('batch', [cropName, batchID]);
    const batchAsBytes = await ctx.stub.getState(batchKey);
    const batch = JSON.parse(batchAsBytes.toString());

    batch.status = 'TRANSFERRED';

    await ctx.stub.putState(batchKey, Buffer.from(JSON.stringify(batch)));
}

async retailBatch(ctx, cropName, batchID, retailerID, transporterID) {
    const batchKey = ctx.stub.createCompositeKey('batch', [cropName, batchID]);
    const batchAsBytes = await ctx.stub.getState(batchKey);
    const batch = JSON.parse(batchAsBytes.toString());

    batch.status = 'RETAILED';
    batch.retailerID = retailerID;
    batch.transporterID = transporterID;

    await ctx.stub.putState(batchKey, Buffer.from(JSON.stringify(batch)));
}

async deleteBatch(ctx, farmerID, farmerName, cropName, batchID) {
    const batchKey = ctx.stub.createCompositeKey('batch', [cropName, batchID]);

    await ctx.stub.deleteState(batchKey);
}

async viewBatchHistory(ctx, cropName, batchID) {
    const batchKey = ctx.stub.createCompositeKey('batch', [cropName, batchID]);
    const history = await ctx.stub.getHistoryForKey(batchKey);

    const results = [];
    for (let i = 0; i < history.length; i++) {
        const batch = JSON.parse(history[i].value.toString());
        results.push({
            transaction_id: history[i].tx_id,
            cropName: batch.cropName,
            batchID: batch.batchID,
        });
    }
}
}
 module.exports = {
                registerEntity,
                addBatch,
                transferBatch,
                retailBatch,
                deleteBatch,
                viewBatchHistory,
                viewBatchCurrentState
                };