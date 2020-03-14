--Index Fragmentation Stats
SELECT [index_id],
       [partition_number],
       [alloc_unit_type_desc],
       [index_level],
       [page_count],
       [avg_page_space_used_in_percent]
FROM [sys].[dm_db_index_physical_stats](
                                           DB_ID(),                /*Database */
                                           OBJECT_ID(N'dbo.table'), /* Table (Object_ID) */
                                           1,                      /* Index ID */
                                           NULL,                   /* Partition ID – NULL – all partitions */
                                           'detailed'              /* Mode */
                                       );
