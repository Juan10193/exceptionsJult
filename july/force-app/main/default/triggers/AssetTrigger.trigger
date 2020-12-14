trigger AssetTrigger on Asset (after insert, after update, after delete, after Undelete) {
    new AssetTriggerHandler_cls().run();
}