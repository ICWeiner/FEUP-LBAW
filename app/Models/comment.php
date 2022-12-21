<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class comment extends Model
{
    #use HasFactory;

    protected $primaryKey = 'id_comment';

    protected $table = 'comment';

    public $timestamps = false;

    protected $fillable = [
        'content', 'rating', 'id_review', 'id_user',
    ];

    protected $hidden = [
        'url',
    ];

    protected $casts = [
        'id_comment' => 'integer',
        'content' => 'string',
        'rating' => 'float',
        'id_review' => 'integer',
        'id_user' => 'integer',
    ];

    public function reviewOwner() {
        return $this->belongsTo(product::class);
    }

    public function usersOwner() {
        return $this->hasOne(User::class, 'id_user');
    }
}
