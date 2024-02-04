import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flame/collisions.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:ichack24/auth.dart';


class Farm extends StatefulWidget {
  const Farm({super.key});

  @override
  State<Farm> createState() => _FarmState();
}

class Vegetable extends SpriteComponent with HasGameRef<FarmGame> {
  var random = Random();
  double xSpeed = 0.0;
  Vector2 pos = Vector2.zero();
  Vegetable(pos, this.xSpeed): super(size: Vector2.all(48), position: pos);
  double init = 0.0;
  @override
  Future<void> onLoad() async {
    init = position.x;
    position.x = init + random.nextDouble() * 5;
    sprite = await Sprite.load('pkcoi.png');
    return super.onLoad();
  }
  @override
  void update(double dt) {
    if (position.x > init + 10) {
      xSpeed = -xSpeed;
    }
    if (position.x < init - 10) {
      xSpeed = -xSpeed;
    }
    super.update(dt);
    position += Vector2(xSpeed * dt, 0.0);
  }
}

class Chicken extends SpriteComponent with HasGameRef<FarmGame>, CollisionCallbacks {
  Vector2 velocity = Vector2(0, 0);
  Chicken(this.velocity): super(size: Vector2.all(48));
  @override
  Future<void> onLoad() async {
    position = game.canvasSize / 2;
    final hitBox = CircleHitbox(
        radius: 30,
      );
    
    add(hitBox);
    sprite = await Sprite.load('chkn.png');
    
    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    double eps = 0.0001;
    final collisionPoint = intersectionPoints.first;
    if (other is ScreenHitbox) {
      if ((collisionPoint.x - 0).abs() < eps) {
        velocity.x = -velocity.x;
        velocity.y = velocity.y;
      }

      if ((collisionPoint.x - gameRef.size.x).abs() < eps) {
        velocity.x = -velocity.x;
        velocity.y = velocity.y; 
      }

      if ((collisionPoint.y - 0).abs() < eps) {
        velocity.x = velocity.x;
        velocity.y = -velocity.y;
      }
      if ((collisionPoint.y - gameRef.size.y).abs() < eps) {
        velocity.x = velocity.x;
        velocity.y = -velocity.y;    
      }
    }
  }
  

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;
  }
}

class RBChicken extends SpriteComponent with HasGameRef<FarmGame>, CollisionCallbacks {
  Vector2 velocity = Vector2(0, 0);
  RBChicken(this.velocity): super(size: Vector2.all(48));
  @override
  Future<void> onLoad() async {
    position = game.canvasSize / 2;
    final hitBox = CircleHitbox(
        radius: 30,
      );
    
    add(hitBox);
    sprite = await Sprite.load('rainbowchkn.png');
    
    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    double eps = 0.0001;
    final collisionPoint = intersectionPoints.first;
    if (other is ScreenHitbox) {
      if ((collisionPoint.x - 0).abs() < eps) {
        velocity.x = -velocity.x;
        velocity.y = velocity.y;
      }

      if ((collisionPoint.x - gameRef.size.x).abs() < eps) {
        velocity.x = -velocity.x;
        velocity.y = velocity.y; 
      }

      if ((collisionPoint.y - 0).abs() < eps) {
        velocity.x = velocity.x;
        velocity.y = -velocity.y;
      }
      if ((collisionPoint.y - gameRef.size.y).abs() < eps) {
        velocity.x = velocity.x;
        velocity.y = -velocity.y;    
      }
    }
  }
  

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;
  }
}

class FarmGame extends FlameGame with HasCollisionDetection {
  final user = Auth().currentUser!;
  final db = FirebaseFirestore.instance;

  @override
  Color backgroundColor() => const Color(0x00000000);

  Future<DocumentSnapshot> _fetchUserData() async {
    return await db.collection("users").doc(user.uid).get();
  }

  @override
  void onLoad() {
    final rnd = Random();
    const speed = 50;
  
    add(ScreenHitbox());
    _fetchUserData().then((value) {
      int numPurchases = value["num_purchases"];
      for (var c = 0; c < numPurchases / 10; c++) {
        add(Chicken(Vector2(sin(rnd.nextDouble() * (c + 1)) * speed, cos(rnd.nextDouble() * (c + 1)) * speed)));
        if (c % 20 == 0) {
          add(RBChicken(Vector2(sin(rnd.nextDouble() * (c + 1)) * 1.5 * speed, cos(rnd.nextDouble() * (c + 1)) * 1.5 * speed)));
        }
      }

      for (var c = 0; c < numPurchases / 7; c++) {
        Vector2 initPos = Vector2(20 + rnd.nextDouble() * (canvasSize.x - 40), 20 + rnd.nextDouble() * (canvasSize.y - 60));
        add(Vegetable(initPos, speed * 0.5));
      }
    });
    
  }
}

class _FarmState extends State<Farm> {
  final farmWorld = FarmGame();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/background.png'),
                  fit: BoxFit.cover)),
        ),
        GameWidget(game: farmWorld)
      ],
    );
  }
}
