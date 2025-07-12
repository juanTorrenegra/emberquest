import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

import '../ember_quest.dart';

class Star extends SpriteComponent with HasGameReference<EmberQuestGame> {
  final Vector2 gridPosition;
  double xOffset;

  final Vector2 velocity = Vector2.zero();

  Star({required this.gridPosition, required this.xOffset})
    : super(size: Vector2.all(64), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    final starImage = game.images.fromCache('star.png');
    sprite = Sprite(starImage);
    position = Vector2(
      (gridPosition.x * size.x) + xOffset + (size.x / 2),
      game.size.y - (gridPosition.y * size.y) - (size.y / 2),
    );
    add(RectangleHitbox(collisionType: CollisionType.passive));
    add(
      SizeEffect.by(
        Vector2.all(-24),
        EffectController(
          duration: 0.75,
          reverseDuration: 0.5,
          infinite: true,
          curve: Curves.easeOut,
        ),
      ),
    );
  }

  @override
  void update(double dt) {
    velocity.x = game.objectSpeed;
    position += velocity * dt;
    if (position.x < -size.x || game.health <= 0) {
      removeFromParent();
    }
    super.update(dt);
  }
}

//
//class Star extends SpriteComponent with HasGameReference<EmberQuestGame> {
//  final Vector2 position;
//
//  Star({required this.position}) : super(size: Vector2.all(64), anchor: Anchor.center);
//
//  @override
//  void onLoad() {
//    sprite = Sprite(game.images.fromCache('star.png'));
//    add(RectangleHitbox(size: Vector2.all(64)));
//  }
//
//  void collect() {
//    add(
//      SequenceEffect([
//        ScaleEffect.by(Vector2.all(1.5), EffectController(duration: 0.1)),
//        ScaleEffect.by(Vector2.all(1 / 1.5), EffectController(duration: 0.1)),
//        RemoveEffect(),
//      ]),
//    );
//  }
//}
//
