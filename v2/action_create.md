```php
public function action_create()
{
    if (Input::method() === 'POST') {
        DB::start_transaction();

        try {
            // Insert post
            $post_id = DB::insert('staff_daily_posts')->set([
                'shop_id' => Input::post('shop_id'),
                'title' => Input::post('title'),
                'staff_name' => Input::post('staff_name'),
                'public_date' => Input::post('public_date'),
                'public_status' => Input::post('public_status'),
                'created_at' => date('Y-m-d H:i:s'),
                'updated_at' => date('Y-m-d H:i:s'),
            ])->execute()[0];

            // Insert schedules
            $schedules = Input::post('schedules', []);
            foreach ($schedules as $order => $item) {
                DB::insert('staff_daily_schedules')->set([
                    'post_id' => $post_id,
                    'sort_order' => $order,
                    'time_hh' => $item['time_hh'],
                    'time_mm' => $item['time_mm'],
                    'job_title' => $item['job_title'],
                    'job_content' => $item['job_content'],
                ])->execute();
            }

            // Insert points
            $points = Input::post('points', []);
            foreach ($points as $order => $item) {
                DB::insert('staff_daily_points')->set([
                    'post_id' => $post_id,
                    'sort_order' => $order,
                    'title' => $item['title'],
                    'details' => $item['details'],
                ])->execute();
            }

            DB::commit_transaction();
            Session::set_flash('success', 'Tạo mới thành công');
            return Response::redirect('staffdaily');
        } catch (Exception $e) {
            DB::rollback_transaction();
            Session::set_flash('error', 'Lỗi: ' . $e->getMessage());
        }
    }

    return Response::forge(View::forge('staffdaily/create'));
}
```
