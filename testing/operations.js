const assert= require('assert');

exports.insertDocument = (db, document, collection, callback)=>{
    const coll= db.collection(collection);
    coll.insert(document,(err,result)=>{
        assert.equal(err,null);
        console.log(result.result.n);
        callback(result);
    });
};
exports.findDocument = (db, collection, callback)=>{
    const coll= db.collection(collection);
    coll.find({}).toArray((err,docs)=>{
        assert.equal(err,null);
        console.log("Documents found are "+ docs);
        callback(docs);
    });    
};
exports.updateDocument = (db, document, update, collection, callback)=>{
    const coll= db.collection(collection);
    coll.updateOne(document,{$set:update},null,(err,result)=>{
        assert.equal(err,null);
        console.log("Document Updated");
        callback(result);
    });
};
exports.deleteDocument = (db, document, collection, callback)=>{
    const coll= db.collection(collection);
    coll.deleteOne(document,(err,result)=>{
         assert.equal(err,null);
         console.log("Document Deleted "+ document);
         callback(result);
    });
};