$query = DB::select(
        'id', 'shop_id', 'autonum', 'title', 'slug', 'staff_name', 'job_type_id',
        'joined_3_months', 'age_group', 'shift', 'business_type',
        'thumbnail_image', 'top_image',
        'public_status', 'public_date',
        'created_at', 'updated_at', 'deleted_at'
    )
    ->from('staff_daily_posts')
    ->where('public_status', 'published')
    ->where('public_date', '>=', DB::expr('DATE_SUB(CURDATE(), INTERVAL 3 MONTH)'))
    ->where('deleted_at', null)
    ->and_where('title', 'LIKE', "%{$search}%")
    ->order_by('public_date', 'DESC')
    ->limit($per_page)
    ->offset($offset);

$results = $query->execute()->as_array();
