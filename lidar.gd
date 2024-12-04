extends RayCast3D

var topic_name: String
var frame_id: String
var publisher: GodotRosLaserScanPublisher

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	publisher = GodotRosLaserScanPublisher.new()
	publisher.init(Global.ros2_node, topic_name, 10)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	# TODO: potentially use a parent node to put this code in, eh idrc
	var where = $"../Racecar".position;
	var where_orientation = $"../Racecar".rotation.y;
	
	var distances = [];
	var SCANS = 360;
	for i in range(SCANS):
		position = where;
		
		var rotated_orientation = where_orientation + ((i*2*PI)/SCANS);
		target_position = Vector3(15.0, 0, 0).rotated(Vector3.UP, rotated_orientation );
		force_raycast_update();
		
		var distance = (get_collision_point()-position).length();
		if is_colliding():
			distances.append(distance);
		else:
			distances.append(INF);
			

	var laser_scan: LaserScan = LaserScan.new(); 
	laser_scan.set_frame_id(frame_id);
	laser_scan.set_angle_min(0);
	laser_scan.set_angle_max(((SCANS-1) * 2*PI)/SCANS);
	laser_scan.set_angle_increment(2*PI/SCANS);
	laser_scan.set_time_increment(0.0);
	laser_scan.set_scan_time(delta);
	laser_scan.set_range_max(15.0);
	laser_scan.set_range_min(0.0);
	laser_scan.set_ranges(distances);
	
	publisher.publish(laser_scan); 
