#[test_only]
module price_feed_module_0::price_tests {
    use std::vector;

    use endpoint_v2_common::config_eid_tagged::{EidTagged, tag_with_eid};
    use price_feed_module_0::price::{
        append_eid_tagged_price,
        deserialize_eid_tagged_price_list, extract_eid_tagged_price, new_price, Price, serialize_eid_tagged_price_list,
    };

    #[test]
    fun test_append_extract_eid_tagged_price() {
        let obj = tag_with_eid(
            123,
            new_price(456, 789, 101112),
        );
        let buf = vector<u8>[];
        append_eid_tagged_price(&mut buf, &obj);
        let pos = 0;
        let obj2 = extract_eid_tagged_price(&buf, &mut pos);
        assert!(obj == obj2, 1);
    }

    #[test]
    fun test_append_extract_eid_tagged_price_list() {
        let objs = vector<EidTagged<Price>>[];
        vector::push_back(&mut objs, tag_with_eid(
            123,
            new_price(456, 789, 101112),
        ));
        vector::push_back(&mut objs, tag_with_eid(
            321,
            new_price(654, 987, 111210),
        ));

        let serialized = serialize_eid_tagged_price_list(&objs);
        let objs2 = deserialize_eid_tagged_price_list(&serialized);
        assert!(objs == objs2, 1);
    }
}
