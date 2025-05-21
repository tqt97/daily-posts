# 1.Time Schedule Section (Tối đa 12 block, mặc định 2)


```php
<div id="schedule-section">
    <!-- Template block sẽ clone khi nhấn "+" -->
    <div class="schedule-block" data-index="0">
        <h4>Schedule #1</h4>

        <label>Time:</label>
        <select name="schedules[0][time_hh]">
            <?php for ($i = 0; $i < 24; $i++): ?>
                <option value="<?= str_pad($i, 2, '0', STR_PAD_LEFT) ?>"><?= str_pad($i, 2, '0', STR_PAD_LEFT) ?></option>
            <?php endfor; ?>
        </select>
        :
        <select name="schedules[0][time_mm]">
            <?php for ($i = 0; $i < 60; $i += 5): ?>
                <option value="<?= str_pad($i, 2, '0', STR_PAD_LEFT) ?>"><?= str_pad($i, 2, '0', STR_PAD_LEFT) ?></option>
            <?php endfor; ?>
        </select>

        <label>Job Title:</label>
        <input type="text" name="schedules[0][job_title]" maxlength="50" />

        <label>Job Content:</label>
        <textarea name="schedules[0][job_content]" maxlength="200"></textarea>

        <label>Main Image:</label>
        <input type="file" name="schedules[0][main_image]" />

        <label>Sub Image 1:</label>
        <input type="file" name="schedules[0][sub_image_1]" />

        <label>Sub Image 2:</label>
        <input type="file" name="schedules[0][sub_image_2]" />

        <label>Editor Comment:</label>
        <textarea name="schedules[0][editor_comment]" maxlength="200"></textarea>

        <button type="button" class="delete-schedule" style="display: none;">Delete</button>
    </div>

    <!-- Thêm bằng JS -->
</div>

<button type="button" id="add-schedule">+ Add Schedule</button>
```
# 2.📌 Attractive Points Section (Tối đa 3 block, mặc định 1)
```php
<div id="point-section">
    <div class="point-block" data-index="0">
        <h4>Point #1</h4>

        <label>Title:</label>
        <input type="text" name="points[0][title]" maxlength="50" />

        <label>Details:</label>
        <textarea name="points[0][details]" maxlength="200"></textarea>

        <label>Image:</label>
        <input type="file" name="points[0][image]" />

        <button type="button" class="delete-point" style="display: none;">Delete</button>
    </div>
</div>

<button type="button" id="add-point">+ Add Point</button>
```

# JS
```js
let scheduleIndex = 1;
let pointIndex = 1;

$('#add-schedule').on('click', function () {
    if (scheduleIndex >= 12) return;

    const block = $('.schedule-block').first().clone();
    block.attr('data-index', scheduleIndex);

    // Update name attr
    block.find('input, select, textarea').each(function () {
        const name = $(this).attr('name');
        const newName = name.replace(/\[\d+\]/, `[${scheduleIndex}]`);
        $(this).attr('name', newName).val('');
    });

    block.find('.delete-schedule').show();
    $('#schedule-section').append(block);
    scheduleIndex++;

    toggleScheduleButtons();
});

$(document).on('click', '.delete-schedule', function () {
    $(this).closest('.schedule-block').remove();
    scheduleIndex--;
    reorderScheduleNames();
    toggleScheduleButtons();
});

function reorderScheduleNames() {
    $('#schedule-section .schedule-block').each(function (index) {
        $(this).attr('data-index', index);
        $(this).find('input, select, textarea').each(function () {
            const baseName = $(this).attr('name').replace(/\[\d+\]/, '');
            $(this).attr('name', baseName.replace('[]', '') + `[${index}]`);
        });
    });
}

function toggleScheduleButtons() {
    $('.delete-schedule').hide();
    $('#schedule-section .schedule-block:gt(1) .delete-schedule').show(); // 2 trở đi
    if (scheduleIndex >= 12) $('#add-schedule').hide();
    else $('#add-schedule').show();
}

// Tương tự cho point:
$('#add-point').on('click', function () {
    if (pointIndex >= 3) return;

    const block = $('.point-block').first().clone();
    block.attr('data-index', pointIndex);

    block.find('input, textarea').each(function () {
        const name = $(this).attr('name');
        const newName = name.replace(/\[\d+\]/, `[${pointIndex}]`);
        $(this).attr('name', newName).val('');
    });

    block.find('.delete-point').show();
    $('#point-section').append(block);
    pointIndex++;

    togglePointButtons();
});

$(document).on('click', '.delete-point', function () {
    $(this).closest('.point-block').remove();
    pointIndex--;
    reorderPointNames();
    togglePointButtons();
});

function reorderPointNames() {
    $('#point-section .point-block').each(function (index) {
        $(this).attr('data-index', index);
        $(this).find('input, textarea').each(function () {
            const baseName = $(this).attr('name').replace(/\[\d+\]/, '');
            $(this).attr('name', baseName + `[${index}]`);
        });
    });
}

function togglePointButtons() {
    $('.delete-point').hide();
    $('#point-section .point-block:gt(0) .delete-point').show();
    if (pointIndex >= 3) $('#add-point').hide();
    else $('#add-point').show();
}
```

## sample post
```
$_POST = [
    'schedules' => [
        0 => [
            'time_hh' => '09',
            'time_mm' => '30',
            'job_title' => 'Massage',
            'job_content' => 'Relax neck',
            'editor_comment' => 'Very focused'
        ],
        1 => [...],
        ...
    ],
    'points' => [
        0 => [
            'title' => 'Friendly',
            'details' => 'Always smiling'
        ],
        1 => [...],
        ...
    ]
];

$_FILES = [
    'schedules' => [
        'name' => [
            0 => [
                'main_image' => 'a.jpg',
                'sub_image_1' => 'b.jpg',
                ...
            ]
        ]
    ],
    'points' => [
        'name' => [
            0 => [
                'image' => 'p.jpg'
            ]
        ]
    ]
];

```


