extends Node3D

var publisher: GodotRosLaserScanPublisher
var subscriber: GodotRosSubscriber

#var scanner

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Global.ros2_node
	publisher = GodotRosLaserScanPublisher.new()
	publisher.init(Global.ros2_node, "scan", 10);
	
	#subscriber = GodotRosSubscriber.new()
	#subscriber.init(Global.ros2_node, "data");
	#subscriber.message_received.connect(show_data)
	pass

func show_data(message):
	print(message);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#publisher.publish("poop")
	pass

func _physics_process(delta: float) -> void:
	var scanner: RayCast3D = $Scanner;
	var where = $Racecar.position;
	var where_orientation = $Racecar.rotation.y;
	
	var distances = [];
	var SCANS = 360;
	for i in range(SCANS):
		scanner.position = where;
		
		var rotated_orientation = where_orientation + ((i*2*PI)/SCANS);
		scanner.target_position = Vector3(15.0, 0, 0).rotated(Vector3.UP, rotated_orientation );
		scanner.force_raycast_update();
		
		var distance = (scanner.get_collision_point()-scanner.position).length();
		if scanner.is_colliding():
			distances.append(distance);
		else:
			distances.append(INF);
			

	var laser_scan: LaserScan = LaserScan.new();
	laser_scan.set_angle_min(0);
	laser_scan.set_angle_max(((SCANS-1) * 2*PI)/SCANS);
	laser_scan.set_angle_increment(2*PI/SCANS);
	laser_scan.set_time_increment(0.0);
	laser_scan.set_scan_time(delta);
	laser_scan.set_range_max(15.0);
	laser_scan.set_range_min(0.0);
	laser_scan.set_ranges(distances);
	
	publisher.publish(laser_scan); 
