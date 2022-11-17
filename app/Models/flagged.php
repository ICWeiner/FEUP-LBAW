<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class flagged extends Model
{
    #use HasFactory;

    protected $primaryKey = 'id_flagged';

    protected $table = 'flagged';

    public $timestamps = false;

    protected $fillable = [
        'reason', 'id_review', 'id_comment',
    ];

    protected $hidden = [
        'reason', 'id_review', 'id_comment',
    ];

    protected $casts = [
        'id_flagged' => 'integer',
        'reason' => 'string',
        'id_review' => 'integer',
        'id_comment' => 'integer',
    ];

    public function reviews() {
        return $this->hasMany('App\Models\review');
    }
}
