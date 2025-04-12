/*
 Navicat Premium Dump SQL

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80039 (8.0.39)
 Source Host           : localhost:3306
 Source Schema         : study_room

 Target Server Type    : MySQL
 Target Server Version : 80039 (8.0.39)
 File Encoding         : 65001

 Date: 12/04/2025 15:38:30
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for config
-- ----------------------------
DROP TABLE IF EXISTS `config`;
CREATE TABLE `config`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '配置参数名称',
  `value` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '配置参数值',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '配置文件' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of config
-- ----------------------------
INSERT INTO `config` VALUES (1, 'picture1', 'upload/picture1.jpg');
INSERT INTO `config` VALUES (2, 'picture2', 'upload/picture2.jpg');
INSERT INTO `config` VALUES (3, 'picture3', 'upload/picture3.jpg');
INSERT INTO `config` VALUES (7, 'APIKey', 'ihML0NfEM0jokUAuBD9tbYtW');
INSERT INTO `config` VALUES (8, 'SecretKey', 'WK2bRUFf2uNe3oEoQXULpi8Y37aCvFdD');

-- ----------------------------
-- Table structure for news
-- ----------------------------
DROP TABLE IF EXISTS `news`;
CREATE TABLE `news`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `title` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '标题',
  `introduction` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '简介',
  `picture` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '图片',
  `content` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '内容',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 89 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '公告资讯' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of news
-- ----------------------------
INSERT INTO `news` VALUES (81, '2025-03-31 08:30:35', '有梦想，就要努力去实现', '不管你想要怎样的生活，你都要去努力争取，不多尝试一些事情怎么知道自己适合什么、不适合什么呢?你说你喜欢读书，让我给你列书单，你还问我哪里有那么多时间看书;你说自己梦想的职业是广告文案，问我如何成为一个文案，应该具备哪些素质;你说你计划晨跑，但总是因为学习、工作辛苦或者身体不舒服第二天起不了床;你说你一直梦想一个人去长途旅行，但是没钱，父母觉得危险。', 'upload/news_picture1.jpg', '<p>不管你想要怎样的生活，你都要去努力争取，不多尝试一些事情怎么知道自己适合什么、不适合什么呢?</p><p>你说你喜欢读书，让我给你列书单，你还问我哪里有那么多时间看书;你说自己梦想的职业是广告文案，问我如何成为一个文案，应该具备哪些素质;你说你计划晨跑，但总是因为学习、工作辛苦或者身体不舒服第二天起不了床;你说你一直梦想一个人去长途旅行，但是没钱，父母觉得危险。其实，我已经厌倦了你这样说说而已的把戏，我觉得就算我告诉你如何去做，你也不会照做，因为你根本什么都不做。</p><p>真正有行动力的人不需要别人告诉他如何做，因为他已经在做了。就算碰到问题，他也会自己想办法，自己动手去解决或者主动寻求可以帮助他的人，而不是等着别人为自己解决问题。</p><p>首先要学习独立思考。花一点时间想一下自己喜欢什么，梦想是什么，不要别人说想环游世界，你就说你的梦想是环游世界。</p><p>很多人说现实束缚了自己，其实在这个世界上，我们一直都可以有很多选择，生活的决定权也—直都在自己手上，只是我们缺乏行动力而已。</p><p>如果你觉得安于现状是你想要的，那选择安于现状就会让你幸福和满足;如果你不甘平庸，选择一条改变、进取和奋斗的道路，在这个追求的过程中，你也一样会感到快乐。所谓的成功，即是按照自己想要的生活方式生活。最糟糕的状态，莫过于当你想要选择一条不甘平庸、改变、进取和奋斗的道路时，却以一种安于现状的方式生活，最后抱怨自己没有得到想要的人生。</p><p>因为喜欢，你不是在苦苦坚持，也因为喜欢，你愿意投入时间、精力，长久以往，获得成功就是自然而然的事情。</p>');
INSERT INTO `news` VALUES (82, '2025-03-31 08:30:35', '又是一年毕业季', '又是一年毕业季，感慨万千，还记的自己刚进学校那时候的情景，我拖着沉重的行李箱站在偌大的教学楼前面，感叹自己未来的日子即将在这个陌生的校园里度过，而如今斗转星移，浮光掠影，弹指之间，那些青葱岁月如同白驹过隙般悄然从指缝溜走。过去的种种在胸口交集纠结，像打翻的五味瓶，甜蜜，酸楚，苦涩，一并涌上心头。', 'upload/news_picture2.jpg', '<p>又是一年毕业季，感慨万千，还记的自己刚进学校那时候的情景，我拖着沉重的行李箱站在偌大的教学楼前面，感叹自己未来的日子即将在这个陌生的校园里度过，而如今斗转星移，浮光掠影，弹指之间，那些青葱岁月如同白驹过隙般悄然从指缝溜走。</p><p>过去的种种在胸口交集纠结，像打翻的五味瓶，甜蜜，酸楚，苦涩，一并涌上心头。一直都是晚会的忠实参与者，无论是台前还是幕后，忽然间，角色转变，那种感觉确实难以用语言表达。</p><p>	过去的三年，总是默默地期盼着这个好雨时节，因为这时候，会有灿烂的阳光，会有满目的百花争艳，会有香甜的冰激凌，这是个毕业的季节，当时不经世事的我们会殷切地期待学校那一大堆的活动，期待穿上绚丽的演出服或者礼仪服，站在大礼堂镁光灯下尽情挥洒我们的澎拜的激情。</p><p>百感交集，隔岸观火与身临其境的感觉竟是如此不同。从来没想过一场晚会送走的是我们自己的时候会是怎样的感情，毕业就真的意味着结束吗?倔强的我们不愿意承认，谢谢学弟学妹们慷慨的将这次的主题定为“我们在这里”。我知道，这可能是他们对我们这些过来人的尊敬和施舍。</p><p>没有为这场晚会排练、奔波，没有为班级、学生会、文学院出点力，还真有点不习惯，百般无奈中，用“工作忙”个万能的借口来搪塞自己，欺骗别人。其实自己心里明白，那只是在逃避，只是不愿面对繁华落幕后的萧条和落寞。大四了，大家各奔东西，想凑齐班上的人真的是难上加难，敏燕从越南回来，刚落地就匆匆回了学校，那么恋家的人也启程回来了，睿睿学姐也是从家赶来跟我们团圆。大家—如既往的寒暄、打趣、调侃对方，似乎一切又回到了当初的单纯美好。</p><p>看着舞台上活泼可爱的学弟学妹们，如同一群机灵的小精灵，清澈的眼神，稚嫩的肢体，轻快地步伐，用他们那热情洋溢的舞姿渲染着在场的每一个人，我知道，我不应该羡慕嫉妒他们，不应该顾自怜惜逝去的青春，不应该感叹夕阳无限好，曾经，我们也拥有过，曾经，我们也年轻过，曾经，我们也灿烂过。我深深地告诉自己，人生的每个阶段都是美的，年轻有年轻的活力，成熟也有成熟的魅力。多—份稳重、淡然、优雅，也是漫漫时光掠影遗留下的.珍贵赏赐。</p>');
INSERT INTO `news` VALUES (83, '2025-03-31 08:30:35', '挫折路上，坚持常在心间', '回头看看，你会不会发现，曾经的你在这里摔倒过;回头看看，你是否发现，一次次地重复着，却从没爬起过。而如今，让我们把视线转向前方，那一道道金色的弧线，是流星飞逝的痕迹，或是成功运行的轨道。今天的你，是否要扬帆起航，让幸福来敲门?清晨的太阳撒向大地，神奇的宇宙赋予它神奇的色彩，大自然沐浴着春光，世界因太阳的照射而精彩，林中百鸟啾啾，河水轻轻流淌，汇成清宁的山间小调。', 'upload/news_picture3.jpg', '<p>回头看看，你会不会发现，曾经的你在这里摔倒过;回头看看，你是否发现，一次次地重复着，却从没爬起过。而如今，让我们把视线转向前方，那一道道金色的弧线，是流星飞逝的痕迹，或是成功运行的轨道。今天的你，是否要扬帆起航，让幸福来敲门?</p><p>清晨的太阳撒向大地，神奇的宇宙赋予它神奇的色彩，大自然沐浴着春光，世界因太阳的照射而精彩，林中百鸟啾啾，河水轻轻流淌，汇成清宁的山间小调。</p><p>是的，面对道途上那无情的嘲讽，面对步伐中那重复的摔跤，面对激流与硬石之间猛烈的碰撞，我们必须选择那富于阴雨，却最终见到彩虹的荆棘路。也许，经历了那暴风雨的洗礼，我们便会变得自信，幸福也随之而来。</p><p>司马迁屡遭羞辱，却依然在狱中撰写《史记》，作为一名史学家，不因王权而极度赞赏，也不因卑微而极度批判，然而他在坚持自己操守的同时，却依然要受统治阶级的阻碍，他似乎无权选择自己的本职。但是，他不顾于此，只是在面对道途的阻隔之时，他依然选择了走下去的信念。终于一部开山巨作《史记》诞生，为后人留下一份馈赠，也许在他完成毕生的杰作之时，他微微地笑了，没有什么比梦想实现更快乐的了......</p><p>	或许正如“长风破浪会有时，直挂云帆济沧海”一般，欣欣然地走向看似深渊的崎岖路，而在一番耕耘之后，便会发现这里另有一番天地。也许这就是困难与快乐的交融。</p><p>也许在形形色色的社会中，我们常能看到一份坚持，一份自信，但这里却还有一类人。这类人在暴风雨来临之际，只会闪躲，从未懂得这也是一种历炼，这何尝不是一份快乐。在阴暗的角落里，总是独自在哭，带着伤愁，看不到一点希望。</p><p>我们不能堕落于此，而要像海燕那般，在苍茫的大海上，高傲地飞翔，任何事物都无法阻挡，任何事都是幸福快乐的。</p>');
INSERT INTO `news` VALUES (84, '2025-03-31 08:30:35', '挫折是另一个生命的开端', '当遇到挫折或失败，你是看见失败还是看见机会?挫折是我们每个人成长的必经之路，它不是你想有就有，想没有就没有的。有句名言说的好，如果你想一生摆脱苦难，你就得是神或者是死尸。这句话形象地说明了挫折是伴随着人生的，是谁都逃不掉的。', 'upload/news_picture4.jpg', '<p>当遇到挫折或失败，你是看见失败还是看见机会?</p><p>挫折是我们每个人成长的必经之路，它不是你想有就有，想没有就没有的。有句名言说的好，如果你想一生摆脱苦难，你就得是神或者是死尸。这句话形象地说明了挫折是伴随着人生的，是谁都逃不掉的。</p><p>人生在世，从古到今，不分天子平民，机遇虽有不同，但总不免有身陷困境或遭遇难题之处，这时候唯有通权达变，才能使人转危为安，甚至反败为胜。</p><p>大部分的人，一生当中，最痛苦的经验是失去所爱的人，其次是丢掉一份工作。其实，经得起考验的人，就算是被开除也不会惊慌，要学会面对。</p><p>	“塞翁失马，焉知非福。”人生的道路，并不是每一步都迈向成功，这就是追求的意义。我们还要认识到一点，挫折作为一种情绪状态和一种个人体验，各人的耐受性是大不相同的，有的人经历了一次次挫折，就能够坚忍不拔，百折不挠;有的人稍遇挫折便意志消沉，一蹶不振。所以，挫折感是一种主观感受，因为人的目的和需要不同，成功标准不同，所以同一种活动对于不同的人可能会造成不同的挫折感受。</p><p>凡事皆以平常心来看待，对于生命顺逆不要太执著。能够“破我执”是很高层的人生境界。</p><p>人事的艰难就是一种考验。就像—支剑要有磨刀来磨，剑才会利:一块璞玉要有粗石来磨，才会发出耀眼的光芒。我们能够做到的，只是如何减少、避免那些由于自身的原因所造成的挫折，而在遇到痛苦和挫折之后，则力求化解痛苦，争取幸福。我们要知道，痛苦和挫折是双重性的，它既是我们人生中难以完全避免的，也是我们在争取成功时，不可缺少的一种动力。因为我认为，推动我们奋斗的力量，不仅仅是对成功的渴望，还有为摆脱痛苦和挫折而进行的奋斗。</p>');
INSERT INTO `news` VALUES (85, '2025-03-31 08:30:35', '你要去相信，没有到不了的明天', '有梦想就去努力，因为在这一辈子里面，现在不去勇敢的努力，也许就再也没有机会了。你要去相信，一定要相信，没有到不了的明天。不要被命运打败，让自己变得更强大。不管你现在是一个人走在异乡的街道上始终没有找到一丝归属感，还是你在跟朋友们一起吃饭开心址笑着的时候闪过一丝落寞。', 'upload/news_picture5.jpg', '<p>有梦想就去努力，因为在这一辈子里面，现在不去勇敢的努力，也许就再也没有机会了。你要去相信，一定要相信，没有到不了的明天。不要被命运打败，让自己变得更强大。</p><p>不管你现在是一个人走在异乡的街道上始终没有找到一丝归属感，还是你在跟朋友们一起吃饭开心址笑着的时候闪过一丝落寞。</p><p>	不管你现在是在图书馆里背着怎么也看不进去的英语单词，还是你现在迷茫地看不清未来的方向不知道要往哪走。</p><p>不管你现在是在努力着去实现梦想却没能拉近与梦想的距离，还是你已经慢慢地找不到自己的梦想了。</p><p>你都要去相信，没有到不了的明天。</p><p>	有的时候你的梦想太大，别人说你的梦想根本不可能实现;有的时候你的梦想又太小，又有人说你胸无大志;有的时候你对死党说着将来要去环游世界的梦想，却换来他的不屑一顾，于是你再也不提自己的梦想;有的时候你突然说起将来要开个小店的愿望，却发现你讲述的那个人，并没有听到你在说什么。</p><p>不过又能怎么样呢，未来始终是自己的，梦想始终是自己的，没有人会来帮你实现它。</p><p>也许很多时候我们只是需要朋友的一句鼓励，一句安慰，却也得不到。但是相信我，世界上还有很多人，只是想要和你说说话。</p><p>因为我们都一样。一样的被人说成固执，一样的在追逐他们眼里根本不在意的东西。</p><p>所以，又有什么关系呢，别人始终不是你、不能懂你的心情，你又何必多去解释呢。这个世界会来阻止你，困难也会接踵而至，其实真正关键的只有自己，有没有那个倔强。</p><p>这个世界上没有不带伤的人，真正能治愈自己的，只有自己。</p>');
INSERT INTO `news` VALUES (86, '2025-03-31 08:30:35', '离开是一种痛苦，是一种勇气，但同样也是一个考验，是一个新的开端', '无穷无尽是离愁，天涯海角遍寻思。当离别在即之时，当面对着相濡以沫兄弟般的朋友时，当面对着经历了四年的磨合而形成的真挚友谊之时，我内心激动无语，说一声再见，道一声珍重都很难出口。回想自己四年大学的风风雨雨，回想我们曾经共同经历的岁月流年，我感谢大家的相扶相依，感谢朋友们的莫大支持与帮助。虽然舍不得，但离别的脚步却不因我们的挚情而停滞。', 'upload/news_picture6.jpg', '<p>无穷无尽是离愁，天涯海角遍寻思。当离别在即之时，当面对着相濡以沫兄弟般的朋友时，当面对着经历了四年的磨合而形成的真挚友谊之时，我内心激动无语，说一声再见，道一声珍重都很难出口。回想自己四年大学的风风雨雨，回想我们曾经共同经历的岁月流年，我感谢大家的相扶相依，感谢朋友们的莫大支持与帮助。虽然舍不得，但离别的脚步却不因我们的挚情而停滞。离别的确是一种痛苦，但同样也是我们走入社会，走向新环境、新领域的一个开端，希望大家在以后新的工作岗位上能够确定自己的新起点，坚持不懈，向着更新、更高的目标前进，因为人生最美好的东西永远都在最前方!</p><p>忆往昔峥嵘岁月，看今朝潮起潮落，望未来任重而道远。作为新时代的我们，就应在失败时，能拼搏奋起，去谱写人生的辉煌。在成功时，亦能居安思危，不沉湎于一时的荣耀、鲜花和掌声中，时时刻刻怀着一颗积极寻找自己新的奶酪的心，处变不惊、成败不渝，始终踏着自己坚实的步伐，从零开始，不断向前迈进，这样才能在这风起云涌、变幻莫测的社会大潮中成为真正的弄潮儿!</p>');
INSERT INTO `news` VALUES (87, '2025-03-31 08:30:35', 'Leave未必是一种痛苦', '无穷无尽是离愁，天涯海角遍寻思。当离别在即之时，当面对着相濡以沫兄弟般的朋友时，当面对着经历了四年的磨合而形成的真挚友谊之时，我内心激动无语，说一声再见，道一声珍重都很难出口。回想自己四年大学的风风雨雨，回想我们曾经共同经历的岁月流年，我感谢大家的相扶相依，感谢朋友们的莫大支持与帮助。虽然舍不得，但离别的脚步却不因我们的挚情而停滞。', 'upload/news_picture7.jpg', '<p>无穷无尽是离愁，天涯海角遍寻思。当离别在即之时，当面对着相濡以沫兄弟般的朋友时，当面对着经历了四年的磨合而形成的真挚友谊之时，我内心激动无语，说一声再见，道一声珍重都很难出口。回想自己四年大学的风风雨雨，回想我们曾经共同经历的岁月流年，我感谢大家的相扶相依，感谢朋友们的莫大支持与帮助。虽然舍不得，但离别的脚步却不因我们的挚情而停滞。离别的确是一种痛苦，但同样也是我们走入社会，走向新环境、新领域的一个开端，希望大家在以后新的工作岗位上能够确定自己的新起点，坚持不懈，向着更新、更高的目标前进，因为人生最美好的东西永远都在最前方!</p><p>忆往昔峥嵘岁月，看今朝潮起潮落，望未来任重而道远。作为新时代的我们，就应在失败时，能拼搏奋起，去谱写人生的辉煌。在成功时，亦能居安思危，不沉湎于一时的荣耀、鲜花和掌声中，时时刻刻怀着一颗积极寻找自己新的奶酪的心，处变不惊、成败不渝，始终踏着自己坚实的步伐，从零开始，不断向前迈进，这样才能在这风起云涌、变幻莫测的社会大潮中成为真正的弄潮儿!</p>');
INSERT INTO `news` VALUES (88, '2025-03-31 08:30:35', '坚持才会成功', '回头看看，你会不会发现，曾经的你在这里摔倒过;回头看看，你是否发现，一次次地重复着，却从没爬起过。而如今，让我们把视线转向前方，那一道道金色的弧线，是流星飞逝的痕迹，或是成功运行的轨道。今天的你，是否要扬帆起航，让幸福来敲门?清晨的太阳撒向大地，神奇的宇宙赋予它神奇的色彩，大自然沐浴着春光，世界因太阳的照射而精彩，林中百鸟啾啾，河水轻轻流淌，汇成清宁的山间小调。', 'upload/news_picture8.jpg', '<p>回头看看，你会不会发现，曾经的你在这里摔倒过;回头看看，你是否发现，一次次地重复着，却从没爬起过。而如今，让我们把视线转向前方，那一道道金色的弧线，是流星飞逝的痕迹，或是成功运行的轨道。今天的你，是否要扬帆起航，让幸福来敲门?</p><p>清晨的太阳撒向大地，神奇的宇宙赋予它神奇的色彩，大自然沐浴着春光，世界因太阳的照射而精彩，林中百鸟啾啾，河水轻轻流淌，汇成清宁的山间小调。</p><p>是的，面对道途上那无情的嘲讽，面对步伐中那重复的摔跤，面对激流与硬石之间猛烈的碰撞，我们必须选择那富于阴雨，却最终见到彩虹的荆棘路。也许，经历了那暴风雨的洗礼，我们便会变得自信，幸福也随之而来。</p><p>司马迁屡遭羞辱，却依然在狱中撰写《史记》，作为一名史学家，不因王权而极度赞赏，也不因卑微而极度批判，然而他在坚持自己操守的同时，却依然要受统治阶级的阻碍，他似乎无权选择自己的本职。但是，他不顾于此，只是在面对道途的阻隔之时，他依然选择了走下去的信念。终于一部开山巨作《史记》诞生，为后人留下一份馈赠，也许在他完成毕生的杰作之时，他微微地笑了，没有什么比梦想实现更快乐的了......</p><p>	或许正如“长风破浪会有时，直挂云帆济沧海”一般，欣欣然地走向看似深渊的崎岖路，而在一番耕耘之后，便会发现这里另有一番天地。也许这就是困难与快乐的交融。</p><p>也许在形形色色的社会中，我们常能看到一份坚持，一份自信，但这里却还有一类人。这类人在暴风雨来临之际，只会闪躲，从未懂得这也是一种历炼，这何尝不是一份快乐。在阴暗的角落里，总是独自在哭，带着伤愁，看不到一点希望。</p><p>我们不能堕落于此，而要像海燕那般，在苍茫的大海上，高傲地飞翔，任何事物都无法阻挡，任何事都是幸福快乐的。</p>');

-- ----------------------------
-- Table structure for qiandaoxinxi
-- ----------------------------
DROP TABLE IF EXISTS `qiandaoxinxi`;
CREATE TABLE `qiandaoxinxi`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `mingcheng` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '名称',
  `qiandaoshijian` datetime NULL DEFAULT NULL COMMENT '签到时间',
  `qiandaobeizhu` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '签到备注',
  `xuehao` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '学号',
  `shouji` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '手机',
  `banji` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '班级',
  `shhf` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '回复内容',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1744442887548 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '签到信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qiandaoxinxi
-- ----------------------------
INSERT INTO `qiandaoxinxi` VALUES (1744442786767, '2025-04-12 15:26:26', '大自习室', '2025-04-12 15:26:22', '', '226001617', '18067193356', '22计科2班', '');
INSERT INTO `qiandaoxinxi` VALUES (1744442887547, '2025-04-12 15:28:07', '大自习室', '2025-04-12 15:28:05', '', '226001621', '18067193356', '22计科2班', '');

-- ----------------------------
-- Table structure for qiantuixinxi
-- ----------------------------
DROP TABLE IF EXISTS `qiantuixinxi`;
CREATE TABLE `qiantuixinxi`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `mingcheng` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '名称',
  `qiantuishijian` datetime NULL DEFAULT NULL COMMENT '签退时间',
  `zixishiid` int NULL DEFAULT NULL COMMENT '自习室序号',
  `zuowei` int NULL DEFAULT NULL COMMENT '座位',
  `qiantuibeizhu` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '签退备注',
  `xuehao` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '学号',
  `shouji` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '手机',
  `banji` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '班级',
  `shhf` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '回复内容',
  `zixishichang` double NULL DEFAULT NULL COMMENT '自习时长',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1744442887548 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '签到信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qiantuixinxi
-- ----------------------------
INSERT INTO `qiantuixinxi` VALUES (1744442786767, '2025-04-12 15:29:27', '大自习室', '2025-04-12 15:29:25', 21, 22, '', '226001617', '18067193356', '22计科2班', '', 30.5);
INSERT INTO `qiantuixinxi` VALUES (1744442887547, '2025-04-12 15:28:12', '大自习室', '2025-04-12 15:28:10', 21, 1, '', '226001621', '18067193356', '22计科2班', '', 0.8);

-- ----------------------------
-- Table structure for quxiaoyuyue
-- ----------------------------
DROP TABLE IF EXISTS `quxiaoyuyue`;
CREATE TABLE `quxiaoyuyue`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `yuyuedanhao` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '预约单号',
  `mingcheng` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '名称',
  `tupian` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '图片',
  `yuyueshijian` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '预约时间',
  `quxiaoshijian` datetime NULL DEFAULT NULL COMMENT '取消时间',
  `quxiaoyuanyin` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '取消原因',
  `zixishiid` int NULL DEFAULT NULL COMMENT '自习室序号',
  `zuowei` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '座位',
  `xuehao` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '学号',
  `xingming` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `shouji` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '手机',
  `crossuserid` bigint NULL DEFAULT NULL COMMENT '跨表用户id',
  `crossrefid` bigint NULL DEFAULT NULL COMMENT '跨表主键id',
  `shhf` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '审核回复',
  `userid` bigint NULL DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1744442775673 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '取消预约' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of quxiaoyuyue
-- ----------------------------
INSERT INTO `quxiaoyuyue` VALUES (1744442775672, '2025-04-12 15:26:15', '1744442747685', '大自习室', 'upload/zixishi_tupian1.jpg', '2025-04-12 15:25:49', '2025-04-12 15:26:13', '', 21, '1', '226001617', 'djc', '18067193356', 16, 1744442751640, '', NULL);

-- ----------------------------
-- Table structure for seats_21
-- ----------------------------
DROP TABLE IF EXISTS `seats_21`;
CREATE TABLE `seats_21`  (
  `id` int NOT NULL,
  `status` int NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of seats_21
-- ----------------------------
INSERT INTO `seats_21` VALUES (1, 1);
INSERT INTO `seats_21` VALUES (2, 1);
INSERT INTO `seats_21` VALUES (3, 1);
INSERT INTO `seats_21` VALUES (4, 1);
INSERT INTO `seats_21` VALUES (5, 1);
INSERT INTO `seats_21` VALUES (6, 1);
INSERT INTO `seats_21` VALUES (7, 1);
INSERT INTO `seats_21` VALUES (8, 1);
INSERT INTO `seats_21` VALUES (9, 1);
INSERT INTO `seats_21` VALUES (10, 1);
INSERT INTO `seats_21` VALUES (11, 1);
INSERT INTO `seats_21` VALUES (12, 1);
INSERT INTO `seats_21` VALUES (13, 1);
INSERT INTO `seats_21` VALUES (14, 1);
INSERT INTO `seats_21` VALUES (15, 1);
INSERT INTO `seats_21` VALUES (16, 1);
INSERT INTO `seats_21` VALUES (17, 1);
INSERT INTO `seats_21` VALUES (18, 1);
INSERT INTO `seats_21` VALUES (19, 1);
INSERT INTO `seats_21` VALUES (20, 1);
INSERT INTO `seats_21` VALUES (21, 1);
INSERT INTO `seats_21` VALUES (22, 1);
INSERT INTO `seats_21` VALUES (23, 1);
INSERT INTO `seats_21` VALUES (24, 1);
INSERT INTO `seats_21` VALUES (25, 1);
INSERT INTO `seats_21` VALUES (26, 1);
INSERT INTO `seats_21` VALUES (27, 1);
INSERT INTO `seats_21` VALUES (28, 0);
INSERT INTO `seats_21` VALUES (29, 1);
INSERT INTO `seats_21` VALUES (30, 1);
INSERT INTO `seats_21` VALUES (31, 1);
INSERT INTO `seats_21` VALUES (32, 1);
INSERT INTO `seats_21` VALUES (33, 1);
INSERT INTO `seats_21` VALUES (34, 1);
INSERT INTO `seats_21` VALUES (35, 1);
INSERT INTO `seats_21` VALUES (36, 1);
INSERT INTO `seats_21` VALUES (37, 1);
INSERT INTO `seats_21` VALUES (38, 1);
INSERT INTO `seats_21` VALUES (39, 1);
INSERT INTO `seats_21` VALUES (40, 1);
INSERT INTO `seats_21` VALUES (41, 1);
INSERT INTO `seats_21` VALUES (42, 1);
INSERT INTO `seats_21` VALUES (43, 1);
INSERT INTO `seats_21` VALUES (44, 1);
INSERT INTO `seats_21` VALUES (45, 1);
INSERT INTO `seats_21` VALUES (46, 1);
INSERT INTO `seats_21` VALUES (47, 1);
INSERT INTO `seats_21` VALUES (48, 1);
INSERT INTO `seats_21` VALUES (49, 1);
INSERT INTO `seats_21` VALUES (50, 1);

-- ----------------------------
-- Table structure for seats_22
-- ----------------------------
DROP TABLE IF EXISTS `seats_22`;
CREATE TABLE `seats_22`  (
  `id` int NOT NULL,
  `status` int NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of seats_22
-- ----------------------------
INSERT INTO `seats_22` VALUES (1, 1);
INSERT INTO `seats_22` VALUES (2, 1);
INSERT INTO `seats_22` VALUES (3, 1);
INSERT INTO `seats_22` VALUES (4, 1);
INSERT INTO `seats_22` VALUES (5, 1);
INSERT INTO `seats_22` VALUES (6, 1);
INSERT INTO `seats_22` VALUES (7, 1);
INSERT INTO `seats_22` VALUES (8, 1);
INSERT INTO `seats_22` VALUES (9, 1);
INSERT INTO `seats_22` VALUES (10, 1);
INSERT INTO `seats_22` VALUES (11, 1);
INSERT INTO `seats_22` VALUES (12, 1);
INSERT INTO `seats_22` VALUES (13, 1);
INSERT INTO `seats_22` VALUES (14, 1);
INSERT INTO `seats_22` VALUES (15, 1);
INSERT INTO `seats_22` VALUES (16, 1);
INSERT INTO `seats_22` VALUES (17, 1);
INSERT INTO `seats_22` VALUES (18, 1);
INSERT INTO `seats_22` VALUES (19, 1);
INSERT INTO `seats_22` VALUES (20, 1);
INSERT INTO `seats_22` VALUES (21, 1);
INSERT INTO `seats_22` VALUES (22, 1);
INSERT INTO `seats_22` VALUES (23, 1);
INSERT INTO `seats_22` VALUES (24, 1);
INSERT INTO `seats_22` VALUES (25, 1);
INSERT INTO `seats_22` VALUES (26, 1);
INSERT INTO `seats_22` VALUES (27, 1);
INSERT INTO `seats_22` VALUES (28, 1);
INSERT INTO `seats_22` VALUES (29, 1);
INSERT INTO `seats_22` VALUES (30, 1);
INSERT INTO `seats_22` VALUES (31, 1);
INSERT INTO `seats_22` VALUES (32, 1);
INSERT INTO `seats_22` VALUES (33, 1);
INSERT INTO `seats_22` VALUES (34, 1);
INSERT INTO `seats_22` VALUES (35, 1);
INSERT INTO `seats_22` VALUES (36, 1);
INSERT INTO `seats_22` VALUES (37, 1);
INSERT INTO `seats_22` VALUES (38, 1);
INSERT INTO `seats_22` VALUES (39, 1);
INSERT INTO `seats_22` VALUES (40, 1);
INSERT INTO `seats_22` VALUES (41, 1);
INSERT INTO `seats_22` VALUES (42, 1);
INSERT INTO `seats_22` VALUES (43, 1);
INSERT INTO `seats_22` VALUES (44, 1);
INSERT INTO `seats_22` VALUES (45, 1);
INSERT INTO `seats_22` VALUES (46, 1);
INSERT INTO `seats_22` VALUES (47, 1);
INSERT INTO `seats_22` VALUES (48, 1);
INSERT INTO `seats_22` VALUES (49, 1);
INSERT INTO `seats_22` VALUES (50, 1);
INSERT INTO `seats_22` VALUES (51, 1);
INSERT INTO `seats_22` VALUES (52, 1);
INSERT INTO `seats_22` VALUES (53, 1);
INSERT INTO `seats_22` VALUES (54, 1);
INSERT INTO `seats_22` VALUES (55, 1);
INSERT INTO `seats_22` VALUES (56, 1);
INSERT INTO `seats_22` VALUES (57, 1);
INSERT INTO `seats_22` VALUES (58, 1);
INSERT INTO `seats_22` VALUES (59, 1);
INSERT INTO `seats_22` VALUES (60, 1);
INSERT INTO `seats_22` VALUES (61, 1);
INSERT INTO `seats_22` VALUES (62, 1);
INSERT INTO `seats_22` VALUES (63, 1);
INSERT INTO `seats_22` VALUES (64, 1);
INSERT INTO `seats_22` VALUES (65, 1);
INSERT INTO `seats_22` VALUES (66, 1);
INSERT INTO `seats_22` VALUES (67, 1);
INSERT INTO `seats_22` VALUES (68, 1);
INSERT INTO `seats_22` VALUES (69, 1);
INSERT INTO `seats_22` VALUES (70, 1);
INSERT INTO `seats_22` VALUES (71, 1);
INSERT INTO `seats_22` VALUES (72, 1);
INSERT INTO `seats_22` VALUES (73, 1);
INSERT INTO `seats_22` VALUES (74, 1);
INSERT INTO `seats_22` VALUES (75, 1);
INSERT INTO `seats_22` VALUES (76, 1);
INSERT INTO `seats_22` VALUES (77, 1);
INSERT INTO `seats_22` VALUES (78, 1);
INSERT INTO `seats_22` VALUES (79, 1);
INSERT INTO `seats_22` VALUES (80, 1);
INSERT INTO `seats_22` VALUES (81, 1);
INSERT INTO `seats_22` VALUES (82, 1);
INSERT INTO `seats_22` VALUES (83, 1);
INSERT INTO `seats_22` VALUES (84, 1);
INSERT INTO `seats_22` VALUES (85, 1);
INSERT INTO `seats_22` VALUES (86, 1);
INSERT INTO `seats_22` VALUES (87, 1);
INSERT INTO `seats_22` VALUES (88, 1);
INSERT INTO `seats_22` VALUES (89, 1);
INSERT INTO `seats_22` VALUES (90, 1);
INSERT INTO `seats_22` VALUES (91, 1);
INSERT INTO `seats_22` VALUES (92, 1);
INSERT INTO `seats_22` VALUES (93, 1);
INSERT INTO `seats_22` VALUES (94, 1);
INSERT INTO `seats_22` VALUES (95, 1);
INSERT INTO `seats_22` VALUES (96, 1);
INSERT INTO `seats_22` VALUES (97, 1);
INSERT INTO `seats_22` VALUES (98, 1);
INSERT INTO `seats_22` VALUES (99, 1);
INSERT INTO `seats_22` VALUES (100, 1);

-- ----------------------------
-- Table structure for seats_23
-- ----------------------------
DROP TABLE IF EXISTS `seats_23`;
CREATE TABLE `seats_23`  (
  `id` int NOT NULL,
  `status` int NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of seats_23
-- ----------------------------
INSERT INTO `seats_23` VALUES (1, 1);
INSERT INTO `seats_23` VALUES (2, 1);
INSERT INTO `seats_23` VALUES (3, 1);
INSERT INTO `seats_23` VALUES (4, 1);
INSERT INTO `seats_23` VALUES (5, 1);
INSERT INTO `seats_23` VALUES (6, 1);
INSERT INTO `seats_23` VALUES (7, 1);
INSERT INTO `seats_23` VALUES (8, 1);
INSERT INTO `seats_23` VALUES (9, 1);
INSERT INTO `seats_23` VALUES (10, 1);
INSERT INTO `seats_23` VALUES (11, 1);
INSERT INTO `seats_23` VALUES (12, 1);
INSERT INTO `seats_23` VALUES (13, 1);
INSERT INTO `seats_23` VALUES (14, 1);
INSERT INTO `seats_23` VALUES (15, 1);
INSERT INTO `seats_23` VALUES (16, 1);
INSERT INTO `seats_23` VALUES (17, 1);
INSERT INTO `seats_23` VALUES (18, 1);
INSERT INTO `seats_23` VALUES (19, 1);
INSERT INTO `seats_23` VALUES (20, 1);
INSERT INTO `seats_23` VALUES (21, 1);
INSERT INTO `seats_23` VALUES (22, 1);
INSERT INTO `seats_23` VALUES (23, 1);
INSERT INTO `seats_23` VALUES (24, 1);
INSERT INTO `seats_23` VALUES (25, 1);
INSERT INTO `seats_23` VALUES (26, 1);
INSERT INTO `seats_23` VALUES (27, 1);
INSERT INTO `seats_23` VALUES (28, 1);
INSERT INTO `seats_23` VALUES (29, 1);
INSERT INTO `seats_23` VALUES (30, 1);
INSERT INTO `seats_23` VALUES (31, 1);
INSERT INTO `seats_23` VALUES (32, 1);
INSERT INTO `seats_23` VALUES (33, 1);
INSERT INTO `seats_23` VALUES (34, 1);
INSERT INTO `seats_23` VALUES (35, 1);
INSERT INTO `seats_23` VALUES (36, 1);
INSERT INTO `seats_23` VALUES (37, 1);
INSERT INTO `seats_23` VALUES (38, 1);
INSERT INTO `seats_23` VALUES (39, 1);
INSERT INTO `seats_23` VALUES (40, 1);

-- ----------------------------
-- Table structure for seats_24
-- ----------------------------
DROP TABLE IF EXISTS `seats_24`;
CREATE TABLE `seats_24`  (
  `id` int NOT NULL,
  `status` int NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of seats_24
-- ----------------------------
INSERT INTO `seats_24` VALUES (1, 1);
INSERT INTO `seats_24` VALUES (2, 1);
INSERT INTO `seats_24` VALUES (3, 1);
INSERT INTO `seats_24` VALUES (4, 1);
INSERT INTO `seats_24` VALUES (5, 1);
INSERT INTO `seats_24` VALUES (6, 1);
INSERT INTO `seats_24` VALUES (7, 1);
INSERT INTO `seats_24` VALUES (8, 1);
INSERT INTO `seats_24` VALUES (9, 1);
INSERT INTO `seats_24` VALUES (10, 1);
INSERT INTO `seats_24` VALUES (11, 1);
INSERT INTO `seats_24` VALUES (12, 1);
INSERT INTO `seats_24` VALUES (13, 1);
INSERT INTO `seats_24` VALUES (14, 1);
INSERT INTO `seats_24` VALUES (15, 1);
INSERT INTO `seats_24` VALUES (16, 1);
INSERT INTO `seats_24` VALUES (17, 1);
INSERT INTO `seats_24` VALUES (18, 1);
INSERT INTO `seats_24` VALUES (19, 1);
INSERT INTO `seats_24` VALUES (20, 1);

-- ----------------------------
-- Table structure for seats_25
-- ----------------------------
DROP TABLE IF EXISTS `seats_25`;
CREATE TABLE `seats_25`  (
  `id` int NOT NULL,
  `status` int NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of seats_25
-- ----------------------------
INSERT INTO `seats_25` VALUES (1, 1);
INSERT INTO `seats_25` VALUES (2, 1);
INSERT INTO `seats_25` VALUES (3, 1);
INSERT INTO `seats_25` VALUES (4, 1);
INSERT INTO `seats_25` VALUES (5, 1);
INSERT INTO `seats_25` VALUES (6, 1);
INSERT INTO `seats_25` VALUES (7, 1);
INSERT INTO `seats_25` VALUES (8, 1);
INSERT INTO `seats_25` VALUES (9, 1);
INSERT INTO `seats_25` VALUES (10, 1);
INSERT INTO `seats_25` VALUES (11, 1);
INSERT INTO `seats_25` VALUES (12, 1);
INSERT INTO `seats_25` VALUES (13, 1);
INSERT INTO `seats_25` VALUES (14, 1);
INSERT INTO `seats_25` VALUES (15, 1);
INSERT INTO `seats_25` VALUES (16, 1);
INSERT INTO `seats_25` VALUES (17, 1);
INSERT INTO `seats_25` VALUES (18, 1);
INSERT INTO `seats_25` VALUES (19, 1);
INSERT INTO `seats_25` VALUES (20, 1);
INSERT INTO `seats_25` VALUES (21, 1);
INSERT INTO `seats_25` VALUES (22, 1);
INSERT INTO `seats_25` VALUES (23, 1);
INSERT INTO `seats_25` VALUES (24, 1);
INSERT INTO `seats_25` VALUES (25, 1);
INSERT INTO `seats_25` VALUES (26, 1);
INSERT INTO `seats_25` VALUES (27, 1);
INSERT INTO `seats_25` VALUES (28, 1);
INSERT INTO `seats_25` VALUES (29, 1);
INSERT INTO `seats_25` VALUES (30, 1);
INSERT INTO `seats_25` VALUES (31, 1);
INSERT INTO `seats_25` VALUES (32, 1);
INSERT INTO `seats_25` VALUES (33, 1);
INSERT INTO `seats_25` VALUES (34, 1);
INSERT INTO `seats_25` VALUES (35, 1);
INSERT INTO `seats_25` VALUES (36, 1);
INSERT INTO `seats_25` VALUES (37, 1);
INSERT INTO `seats_25` VALUES (38, 1);
INSERT INTO `seats_25` VALUES (39, 1);
INSERT INTO `seats_25` VALUES (40, 1);
INSERT INTO `seats_25` VALUES (41, 1);
INSERT INTO `seats_25` VALUES (42, 1);
INSERT INTO `seats_25` VALUES (43, 1);
INSERT INTO `seats_25` VALUES (44, 1);
INSERT INTO `seats_25` VALUES (45, 1);
INSERT INTO `seats_25` VALUES (46, 1);
INSERT INTO `seats_25` VALUES (47, 1);
INSERT INTO `seats_25` VALUES (48, 1);
INSERT INTO `seats_25` VALUES (49, 1);
INSERT INTO `seats_25` VALUES (50, 1);
INSERT INTO `seats_25` VALUES (51, 1);
INSERT INTO `seats_25` VALUES (52, 1);
INSERT INTO `seats_25` VALUES (53, 1);
INSERT INTO `seats_25` VALUES (54, 1);
INSERT INTO `seats_25` VALUES (55, 1);
INSERT INTO `seats_25` VALUES (56, 1);
INSERT INTO `seats_25` VALUES (57, 1);
INSERT INTO `seats_25` VALUES (58, 1);
INSERT INTO `seats_25` VALUES (59, 1);
INSERT INTO `seats_25` VALUES (60, 1);
INSERT INTO `seats_25` VALUES (61, 1);
INSERT INTO `seats_25` VALUES (62, 1);
INSERT INTO `seats_25` VALUES (63, 1);
INSERT INTO `seats_25` VALUES (64, 1);
INSERT INTO `seats_25` VALUES (65, 1);
INSERT INTO `seats_25` VALUES (66, 1);
INSERT INTO `seats_25` VALUES (67, 1);
INSERT INTO `seats_25` VALUES (68, 1);
INSERT INTO `seats_25` VALUES (69, 1);
INSERT INTO `seats_25` VALUES (70, 1);
INSERT INTO `seats_25` VALUES (71, 1);
INSERT INTO `seats_25` VALUES (72, 1);
INSERT INTO `seats_25` VALUES (73, 1);
INSERT INTO `seats_25` VALUES (74, 1);
INSERT INTO `seats_25` VALUES (75, 1);
INSERT INTO `seats_25` VALUES (76, 1);
INSERT INTO `seats_25` VALUES (77, 1);
INSERT INTO `seats_25` VALUES (78, 1);
INSERT INTO `seats_25` VALUES (79, 1);
INSERT INTO `seats_25` VALUES (80, 1);

-- ----------------------------
-- Table structure for seats_26
-- ----------------------------
DROP TABLE IF EXISTS `seats_26`;
CREATE TABLE `seats_26`  (
  `id` int NOT NULL,
  `status` int NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of seats_26
-- ----------------------------
INSERT INTO `seats_26` VALUES (1, 1);
INSERT INTO `seats_26` VALUES (2, 1);
INSERT INTO `seats_26` VALUES (3, 1);
INSERT INTO `seats_26` VALUES (4, 1);
INSERT INTO `seats_26` VALUES (5, 1);
INSERT INTO `seats_26` VALUES (6, 1);
INSERT INTO `seats_26` VALUES (7, 1);
INSERT INTO `seats_26` VALUES (8, 1);
INSERT INTO `seats_26` VALUES (9, 1);
INSERT INTO `seats_26` VALUES (10, 1);
INSERT INTO `seats_26` VALUES (11, 1);
INSERT INTO `seats_26` VALUES (12, 1);
INSERT INTO `seats_26` VALUES (13, 1);
INSERT INTO `seats_26` VALUES (14, 1);
INSERT INTO `seats_26` VALUES (15, 1);
INSERT INTO `seats_26` VALUES (16, 1);
INSERT INTO `seats_26` VALUES (17, 1);
INSERT INTO `seats_26` VALUES (18, 1);
INSERT INTO `seats_26` VALUES (19, 1);
INSERT INTO `seats_26` VALUES (20, 1);
INSERT INTO `seats_26` VALUES (21, 1);
INSERT INTO `seats_26` VALUES (22, 1);
INSERT INTO `seats_26` VALUES (23, 1);
INSERT INTO `seats_26` VALUES (24, 1);
INSERT INTO `seats_26` VALUES (25, 1);
INSERT INTO `seats_26` VALUES (26, 1);
INSERT INTO `seats_26` VALUES (27, 1);
INSERT INTO `seats_26` VALUES (28, 1);
INSERT INTO `seats_26` VALUES (29, 1);
INSERT INTO `seats_26` VALUES (30, 1);
INSERT INTO `seats_26` VALUES (31, 1);
INSERT INTO `seats_26` VALUES (32, 1);
INSERT INTO `seats_26` VALUES (33, 1);
INSERT INTO `seats_26` VALUES (34, 1);
INSERT INTO `seats_26` VALUES (35, 1);
INSERT INTO `seats_26` VALUES (36, 1);
INSERT INTO `seats_26` VALUES (37, 1);
INSERT INTO `seats_26` VALUES (38, 1);
INSERT INTO `seats_26` VALUES (39, 1);
INSERT INTO `seats_26` VALUES (40, 1);
INSERT INTO `seats_26` VALUES (41, 1);
INSERT INTO `seats_26` VALUES (42, 1);
INSERT INTO `seats_26` VALUES (43, 1);
INSERT INTO `seats_26` VALUES (44, 1);
INSERT INTO `seats_26` VALUES (45, 1);
INSERT INTO `seats_26` VALUES (46, 1);
INSERT INTO `seats_26` VALUES (47, 1);
INSERT INTO `seats_26` VALUES (48, 1);
INSERT INTO `seats_26` VALUES (49, 1);
INSERT INTO `seats_26` VALUES (50, 1);
INSERT INTO `seats_26` VALUES (51, 1);
INSERT INTO `seats_26` VALUES (52, 1);
INSERT INTO `seats_26` VALUES (53, 1);
INSERT INTO `seats_26` VALUES (54, 1);
INSERT INTO `seats_26` VALUES (55, 1);
INSERT INTO `seats_26` VALUES (56, 1);
INSERT INTO `seats_26` VALUES (57, 1);
INSERT INTO `seats_26` VALUES (58, 1);
INSERT INTO `seats_26` VALUES (59, 1);
INSERT INTO `seats_26` VALUES (60, 1);
INSERT INTO `seats_26` VALUES (61, 1);
INSERT INTO `seats_26` VALUES (62, 1);
INSERT INTO `seats_26` VALUES (63, 1);
INSERT INTO `seats_26` VALUES (64, 1);
INSERT INTO `seats_26` VALUES (65, 1);
INSERT INTO `seats_26` VALUES (66, 1);
INSERT INTO `seats_26` VALUES (67, 1);
INSERT INTO `seats_26` VALUES (68, 1);
INSERT INTO `seats_26` VALUES (69, 1);
INSERT INTO `seats_26` VALUES (70, 1);
INSERT INTO `seats_26` VALUES (71, 1);
INSERT INTO `seats_26` VALUES (72, 1);
INSERT INTO `seats_26` VALUES (73, 1);
INSERT INTO `seats_26` VALUES (74, 1);
INSERT INTO `seats_26` VALUES (75, 1);
INSERT INTO `seats_26` VALUES (76, 1);
INSERT INTO `seats_26` VALUES (77, 1);
INSERT INTO `seats_26` VALUES (78, 1);
INSERT INTO `seats_26` VALUES (79, 1);
INSERT INTO `seats_26` VALUES (80, 1);
INSERT INTO `seats_26` VALUES (81, 1);
INSERT INTO `seats_26` VALUES (82, 1);
INSERT INTO `seats_26` VALUES (83, 1);
INSERT INTO `seats_26` VALUES (84, 1);
INSERT INTO `seats_26` VALUES (85, 1);
INSERT INTO `seats_26` VALUES (86, 1);
INSERT INTO `seats_26` VALUES (87, 1);
INSERT INTO `seats_26` VALUES (88, 1);
INSERT INTO `seats_26` VALUES (89, 1);
INSERT INTO `seats_26` VALUES (90, 1);

-- ----------------------------
-- Table structure for seats_27
-- ----------------------------
DROP TABLE IF EXISTS `seats_27`;
CREATE TABLE `seats_27`  (
  `id` int NOT NULL,
  `status` int NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of seats_27
-- ----------------------------
INSERT INTO `seats_27` VALUES (1, 1);
INSERT INTO `seats_27` VALUES (2, 1);
INSERT INTO `seats_27` VALUES (3, 1);
INSERT INTO `seats_27` VALUES (4, 1);
INSERT INTO `seats_27` VALUES (5, 1);
INSERT INTO `seats_27` VALUES (6, 1);
INSERT INTO `seats_27` VALUES (7, 1);
INSERT INTO `seats_27` VALUES (8, 1);
INSERT INTO `seats_27` VALUES (9, 1);
INSERT INTO `seats_27` VALUES (10, 1);
INSERT INTO `seats_27` VALUES (11, 1);
INSERT INTO `seats_27` VALUES (12, 1);
INSERT INTO `seats_27` VALUES (13, 1);
INSERT INTO `seats_27` VALUES (14, 1);
INSERT INTO `seats_27` VALUES (15, 1);
INSERT INTO `seats_27` VALUES (16, 1);
INSERT INTO `seats_27` VALUES (17, 1);
INSERT INTO `seats_27` VALUES (18, 1);
INSERT INTO `seats_27` VALUES (19, 1);
INSERT INTO `seats_27` VALUES (20, 1);
INSERT INTO `seats_27` VALUES (21, 1);
INSERT INTO `seats_27` VALUES (22, 1);
INSERT INTO `seats_27` VALUES (23, 1);
INSERT INTO `seats_27` VALUES (24, 1);
INSERT INTO `seats_27` VALUES (25, 1);
INSERT INTO `seats_27` VALUES (26, 1);
INSERT INTO `seats_27` VALUES (27, 1);
INSERT INTO `seats_27` VALUES (28, 1);
INSERT INTO `seats_27` VALUES (29, 1);
INSERT INTO `seats_27` VALUES (30, 1);
INSERT INTO `seats_27` VALUES (31, 1);
INSERT INTO `seats_27` VALUES (32, 1);
INSERT INTO `seats_27` VALUES (33, 1);
INSERT INTO `seats_27` VALUES (34, 1);
INSERT INTO `seats_27` VALUES (35, 1);
INSERT INTO `seats_27` VALUES (36, 1);
INSERT INTO `seats_27` VALUES (37, 1);
INSERT INTO `seats_27` VALUES (38, 1);
INSERT INTO `seats_27` VALUES (39, 1);
INSERT INTO `seats_27` VALUES (40, 1);
INSERT INTO `seats_27` VALUES (41, 1);
INSERT INTO `seats_27` VALUES (42, 1);
INSERT INTO `seats_27` VALUES (43, 1);
INSERT INTO `seats_27` VALUES (44, 1);
INSERT INTO `seats_27` VALUES (45, 1);
INSERT INTO `seats_27` VALUES (46, 1);
INSERT INTO `seats_27` VALUES (47, 1);
INSERT INTO `seats_27` VALUES (48, 1);
INSERT INTO `seats_27` VALUES (49, 1);
INSERT INTO `seats_27` VALUES (50, 1);
INSERT INTO `seats_27` VALUES (51, 1);
INSERT INTO `seats_27` VALUES (52, 1);
INSERT INTO `seats_27` VALUES (53, 1);
INSERT INTO `seats_27` VALUES (54, 1);
INSERT INTO `seats_27` VALUES (55, 1);
INSERT INTO `seats_27` VALUES (56, 1);
INSERT INTO `seats_27` VALUES (57, 1);
INSERT INTO `seats_27` VALUES (58, 1);
INSERT INTO `seats_27` VALUES (59, 1);
INSERT INTO `seats_27` VALUES (60, 1);
INSERT INTO `seats_27` VALUES (61, 1);
INSERT INTO `seats_27` VALUES (62, 1);
INSERT INTO `seats_27` VALUES (63, 1);
INSERT INTO `seats_27` VALUES (64, 1);
INSERT INTO `seats_27` VALUES (65, 1);
INSERT INTO `seats_27` VALUES (66, 1);
INSERT INTO `seats_27` VALUES (67, 1);
INSERT INTO `seats_27` VALUES (68, 1);
INSERT INTO `seats_27` VALUES (69, 1);
INSERT INTO `seats_27` VALUES (70, 1);
INSERT INTO `seats_27` VALUES (71, 1);
INSERT INTO `seats_27` VALUES (72, 1);
INSERT INTO `seats_27` VALUES (73, 1);
INSERT INTO `seats_27` VALUES (74, 1);
INSERT INTO `seats_27` VALUES (75, 1);
INSERT INTO `seats_27` VALUES (76, 1);
INSERT INTO `seats_27` VALUES (77, 1);
INSERT INTO `seats_27` VALUES (78, 1);
INSERT INTO `seats_27` VALUES (79, 1);
INSERT INTO `seats_27` VALUES (80, 1);
INSERT INTO `seats_27` VALUES (81, 1);
INSERT INTO `seats_27` VALUES (82, 1);
INSERT INTO `seats_27` VALUES (83, 1);
INSERT INTO `seats_27` VALUES (84, 1);
INSERT INTO `seats_27` VALUES (85, 1);
INSERT INTO `seats_27` VALUES (86, 1);
INSERT INTO `seats_27` VALUES (87, 1);
INSERT INTO `seats_27` VALUES (88, 1);
INSERT INTO `seats_27` VALUES (89, 1);
INSERT INTO `seats_27` VALUES (90, 1);
INSERT INTO `seats_27` VALUES (91, 1);
INSERT INTO `seats_27` VALUES (92, 1);
INSERT INTO `seats_27` VALUES (93, 1);
INSERT INTO `seats_27` VALUES (94, 1);
INSERT INTO `seats_27` VALUES (95, 1);
INSERT INTO `seats_27` VALUES (96, 1);
INSERT INTO `seats_27` VALUES (97, 1);
INSERT INTO `seats_27` VALUES (98, 1);
INSERT INTO `seats_27` VALUES (99, 1);
INSERT INTO `seats_27` VALUES (100, 1);
INSERT INTO `seats_27` VALUES (101, 1);
INSERT INTO `seats_27` VALUES (102, 1);
INSERT INTO `seats_27` VALUES (103, 1);
INSERT INTO `seats_27` VALUES (104, 1);
INSERT INTO `seats_27` VALUES (105, 1);
INSERT INTO `seats_27` VALUES (106, 1);
INSERT INTO `seats_27` VALUES (107, 1);
INSERT INTO `seats_27` VALUES (108, 1);
INSERT INTO `seats_27` VALUES (109, 1);
INSERT INTO `seats_27` VALUES (110, 1);
INSERT INTO `seats_27` VALUES (111, 1);
INSERT INTO `seats_27` VALUES (112, 1);
INSERT INTO `seats_27` VALUES (113, 1);
INSERT INTO `seats_27` VALUES (114, 1);
INSERT INTO `seats_27` VALUES (115, 1);
INSERT INTO `seats_27` VALUES (116, 1);
INSERT INTO `seats_27` VALUES (117, 1);
INSERT INTO `seats_27` VALUES (118, 1);
INSERT INTO `seats_27` VALUES (119, 1);
INSERT INTO `seats_27` VALUES (120, 1);
INSERT INTO `seats_27` VALUES (121, 1);
INSERT INTO `seats_27` VALUES (122, 1);
INSERT INTO `seats_27` VALUES (123, 1);
INSERT INTO `seats_27` VALUES (124, 1);
INSERT INTO `seats_27` VALUES (125, 1);
INSERT INTO `seats_27` VALUES (126, 1);
INSERT INTO `seats_27` VALUES (127, 1);
INSERT INTO `seats_27` VALUES (128, 1);
INSERT INTO `seats_27` VALUES (129, 1);
INSERT INTO `seats_27` VALUES (130, 1);
INSERT INTO `seats_27` VALUES (131, 1);
INSERT INTO `seats_27` VALUES (132, 1);
INSERT INTO `seats_27` VALUES (133, 1);
INSERT INTO `seats_27` VALUES (134, 1);
INSERT INTO `seats_27` VALUES (135, 1);
INSERT INTO `seats_27` VALUES (136, 1);
INSERT INTO `seats_27` VALUES (137, 1);
INSERT INTO `seats_27` VALUES (138, 1);
INSERT INTO `seats_27` VALUES (139, 1);
INSERT INTO `seats_27` VALUES (140, 1);
INSERT INTO `seats_27` VALUES (141, 1);
INSERT INTO `seats_27` VALUES (142, 1);
INSERT INTO `seats_27` VALUES (143, 1);
INSERT INTO `seats_27` VALUES (144, 1);
INSERT INTO `seats_27` VALUES (145, 1);
INSERT INTO `seats_27` VALUES (146, 1);
INSERT INTO `seats_27` VALUES (147, 1);
INSERT INTO `seats_27` VALUES (148, 1);
INSERT INTO `seats_27` VALUES (149, 1);
INSERT INTO `seats_27` VALUES (150, 1);

-- ----------------------------
-- Table structure for seats_28
-- ----------------------------
DROP TABLE IF EXISTS `seats_28`;
CREATE TABLE `seats_28`  (
  `id` int NOT NULL,
  `status` int NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of seats_28
-- ----------------------------
INSERT INTO `seats_28` VALUES (1, 1);
INSERT INTO `seats_28` VALUES (2, 1);
INSERT INTO `seats_28` VALUES (3, 1);
INSERT INTO `seats_28` VALUES (4, 1);
INSERT INTO `seats_28` VALUES (5, 1);
INSERT INTO `seats_28` VALUES (6, 1);
INSERT INTO `seats_28` VALUES (7, 1);
INSERT INTO `seats_28` VALUES (8, 1);
INSERT INTO `seats_28` VALUES (9, 1);
INSERT INTO `seats_28` VALUES (10, 1);
INSERT INTO `seats_28` VALUES (11, 1);
INSERT INTO `seats_28` VALUES (12, 1);
INSERT INTO `seats_28` VALUES (13, 1);
INSERT INTO `seats_28` VALUES (14, 1);
INSERT INTO `seats_28` VALUES (15, 1);
INSERT INTO `seats_28` VALUES (16, 1);
INSERT INTO `seats_28` VALUES (17, 1);
INSERT INTO `seats_28` VALUES (18, 1);
INSERT INTO `seats_28` VALUES (19, 1);
INSERT INTO `seats_28` VALUES (20, 1);
INSERT INTO `seats_28` VALUES (21, 1);
INSERT INTO `seats_28` VALUES (22, 1);
INSERT INTO `seats_28` VALUES (23, 1);
INSERT INTO `seats_28` VALUES (24, 1);
INSERT INTO `seats_28` VALUES (25, 1);
INSERT INTO `seats_28` VALUES (26, 1);
INSERT INTO `seats_28` VALUES (27, 1);
INSERT INTO `seats_28` VALUES (28, 1);
INSERT INTO `seats_28` VALUES (29, 1);
INSERT INTO `seats_28` VALUES (30, 1);
INSERT INTO `seats_28` VALUES (31, 1);
INSERT INTO `seats_28` VALUES (32, 1);
INSERT INTO `seats_28` VALUES (33, 1);
INSERT INTO `seats_28` VALUES (34, 1);
INSERT INTO `seats_28` VALUES (35, 1);
INSERT INTO `seats_28` VALUES (36, 1);
INSERT INTO `seats_28` VALUES (37, 1);
INSERT INTO `seats_28` VALUES (38, 1);
INSERT INTO `seats_28` VALUES (39, 1);
INSERT INTO `seats_28` VALUES (40, 1);
INSERT INTO `seats_28` VALUES (41, 1);
INSERT INTO `seats_28` VALUES (42, 1);
INSERT INTO `seats_28` VALUES (43, 1);
INSERT INTO `seats_28` VALUES (44, 1);
INSERT INTO `seats_28` VALUES (45, 1);
INSERT INTO `seats_28` VALUES (46, 1);
INSERT INTO `seats_28` VALUES (47, 1);
INSERT INTO `seats_28` VALUES (48, 1);
INSERT INTO `seats_28` VALUES (49, 1);
INSERT INTO `seats_28` VALUES (50, 1);
INSERT INTO `seats_28` VALUES (51, 1);
INSERT INTO `seats_28` VALUES (52, 1);
INSERT INTO `seats_28` VALUES (53, 1);
INSERT INTO `seats_28` VALUES (54, 1);
INSERT INTO `seats_28` VALUES (55, 1);
INSERT INTO `seats_28` VALUES (56, 1);
INSERT INTO `seats_28` VALUES (57, 1);
INSERT INTO `seats_28` VALUES (58, 1);
INSERT INTO `seats_28` VALUES (59, 1);
INSERT INTO `seats_28` VALUES (60, 1);
INSERT INTO `seats_28` VALUES (61, 1);
INSERT INTO `seats_28` VALUES (62, 1);
INSERT INTO `seats_28` VALUES (63, 1);
INSERT INTO `seats_28` VALUES (64, 1);
INSERT INTO `seats_28` VALUES (65, 1);
INSERT INTO `seats_28` VALUES (66, 1);
INSERT INTO `seats_28` VALUES (67, 1);
INSERT INTO `seats_28` VALUES (68, 1);
INSERT INTO `seats_28` VALUES (69, 1);
INSERT INTO `seats_28` VALUES (70, 1);
INSERT INTO `seats_28` VALUES (71, 1);
INSERT INTO `seats_28` VALUES (72, 1);
INSERT INTO `seats_28` VALUES (73, 1);
INSERT INTO `seats_28` VALUES (74, 1);
INSERT INTO `seats_28` VALUES (75, 1);
INSERT INTO `seats_28` VALUES (76, 1);
INSERT INTO `seats_28` VALUES (77, 1);
INSERT INTO `seats_28` VALUES (78, 1);
INSERT INTO `seats_28` VALUES (79, 1);
INSERT INTO `seats_28` VALUES (80, 1);
INSERT INTO `seats_28` VALUES (81, 1);
INSERT INTO `seats_28` VALUES (82, 1);
INSERT INTO `seats_28` VALUES (83, 1);
INSERT INTO `seats_28` VALUES (84, 1);
INSERT INTO `seats_28` VALUES (85, 1);
INSERT INTO `seats_28` VALUES (86, 1);
INSERT INTO `seats_28` VALUES (87, 1);
INSERT INTO `seats_28` VALUES (88, 1);
INSERT INTO `seats_28` VALUES (89, 1);
INSERT INTO `seats_28` VALUES (90, 1);
INSERT INTO `seats_28` VALUES (91, 1);
INSERT INTO `seats_28` VALUES (92, 1);
INSERT INTO `seats_28` VALUES (93, 1);
INSERT INTO `seats_28` VALUES (94, 1);
INSERT INTO `seats_28` VALUES (95, 1);
INSERT INTO `seats_28` VALUES (96, 1);
INSERT INTO `seats_28` VALUES (97, 1);
INSERT INTO `seats_28` VALUES (98, 1);
INSERT INTO `seats_28` VALUES (99, 1);
INSERT INTO `seats_28` VALUES (100, 1);

-- ----------------------------
-- Table structure for storeup
-- ----------------------------
DROP TABLE IF EXISTS `storeup`;
CREATE TABLE `storeup`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `userid` bigint NOT NULL COMMENT '用户id',
  `refid` bigint NULL DEFAULT NULL COMMENT '商品id',
  `tablename` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '表名',
  `name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '名称',
  `picture` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '图片',
  `type` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '1' COMMENT '类型(1:收藏,21:赞,22:踩,31:竞拍参与,41:关注)',
  `inteltype` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '推荐类型',
  `remark` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1743651086108 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '收藏表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of storeup
-- ----------------------------
INSERT INTO `storeup` VALUES (1743159939726, '2025-03-28 19:05:39', 1743085507549, 21, 'zixishi', '名称1', 'upload/zixishi_tupian1.jpg', '1', NULL, NULL);
INSERT INTO `storeup` VALUES (1743159952733, '2025-03-28 19:05:51', 1743085507549, 21, 'zixishi', '名称1', 'upload/zixishi_tupian1.jpg', '1', NULL, NULL);
INSERT INTO `storeup` VALUES (1743650978022, '2025-04-03 11:29:37', 17, 21, 'zixishi', '自习室1', 'upload/zixishi_tupian1.jpg', '1', NULL, NULL);
INSERT INTO `storeup` VALUES (1743651084416, '2025-04-03 11:31:23', 17, 22, 'zixishi', '图书馆', 'upload/zixishi_tupian2.jpg', '1', NULL, NULL);
INSERT INTO `storeup` VALUES (1743651086107, '2025-04-03 11:31:25', 16, 21, 'zixishi', '大自习室', 'upload/zixishi_tupian1.jpg', '1', NULL, NULL);

-- ----------------------------
-- Table structure for token
-- ----------------------------
DROP TABLE IF EXISTS `token`;
CREATE TABLE `token`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `userid` bigint NOT NULL COMMENT '用户id',
  `username` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '用户名',
  `tablename` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '表名',
  `role` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '角色',
  `token` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '密码',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `expiratedtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '过期时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = 'token表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of token
-- ----------------------------
INSERT INTO `token` VALUES (1, 1, 'admin', 'users', '管理员', 'diacckdp0veem4iyz8m6o5v8dwvhiq6i', '2025-03-27 21:16:56', '2025-04-12 16:37:31');
INSERT INTO `token` VALUES (2, 1743085507549, '123', 'xuesheng', '学生', 'zo7ixex3883guysc1ebich5yjmiqyalx', '2025-03-27 22:25:14', '2025-04-03 12:02:28');
INSERT INTO `token` VALUES (3, 17, '226001682', 'xuesheng', '学生', 'ed85x895onfopadw96vqdoup45ne8k1f', '2025-04-03 11:29:12', '2025-04-03 12:29:13');
INSERT INTO `token` VALUES (4, 16, '226001617', 'xuesheng', '学生', 'trf0sx7p7qmk3ez088gzd85y6prrfgdi', '2025-04-03 11:29:36', '2025-04-12 16:29:19');
INSERT INTO `token` VALUES (5, 18, '226001621', 'xuesheng', '学生', 'vdr7ucwn94ibqu4ui6ygmpanhhysm5wp', '2025-04-03 13:21:05', '2025-04-12 16:27:49');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '密码',
  `role` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '管理员' COMMENT '角色',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'DJC', '123', '管理员', '2023-03-08 10:25:42');

-- ----------------------------
-- Table structure for xuesheng
-- ----------------------------
DROP TABLE IF EXISTS `xuesheng`;
CREATE TABLE `xuesheng`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `xuehao` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '学号',
  `mima` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '密码',
  `xingming` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '姓名',
  `xingbie` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '性别',
  `touxiang` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '头像',
  `shouji` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '手机',
  `banji` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '班级',
  `zixishichang` double NULL DEFAULT NULL COMMENT '自习时长',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `xuehao`(`xuehao` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1743085507550 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '学生' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of xuesheng
-- ----------------------------
INSERT INTO `xuesheng` VALUES (15, '2023-03-08 10:25:42', '216001939', '123456', 'yyq', '男', 'upload/xuesheng_touxiang5.jpg', '12345678910', '21计科1班', 100);
INSERT INTO `xuesheng` VALUES (16, '2023-03-08 10:25:42', '226001617', '123456', 'djc', '男', 'upload/xuesheng_touxiang6.jpg', '18067193356', '22计科2班', 330.5);
INSERT INTO `xuesheng` VALUES (17, '2023-03-08 10:25:42', '226001682', '123456', 'zyc', '女', 'upload/xuesheng_touxiang7.jpg', '12345678910', '22计科2班', 120);
INSERT INTO `xuesheng` VALUES (18, '2023-03-08 10:25:42', '226001621', '123456', 'ftz', '女', 'upload/xuesheng_touxiang8.jpg', '18067193356', '22计科2班', 120.8);
INSERT INTO `xuesheng` VALUES (1743085507549, '2025-03-27 22:25:07', '123', '123', 'djc', '', NULL, NULL, NULL, 0);

-- ----------------------------
-- Table structure for yuyuexinxi
-- ----------------------------
DROP TABLE IF EXISTS `yuyuexinxi`;
CREATE TABLE `yuyuexinxi`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `zixishiid` int NULL DEFAULT NULL COMMENT '自习室编号',
  `yuyuedanhao` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '预约单号',
  `mingcheng` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '名称',
  `tupian` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '图片',
  `zuowei` int NULL DEFAULT NULL COMMENT '座位',
  `qiandaozhuangtai` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '签到状态',
  `qiantuizhuangtai` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '签退状态',
  `yuyueshijian` datetime NOT NULL COMMENT '预约时间',
  `beizhu` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  `xuehao` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '学号',
  `xingming` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `shouji` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '手机',
  `shhf` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '回复',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `yuyuedanhao`(`yuyuedanhao` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1744442877354 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '预约信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of yuyuexinxi
-- ----------------------------
INSERT INTO `yuyuexinxi` VALUES (1744442751640, '2025-04-12 15:25:51', 21, '1744442747685', '大自习室', 'upload/zixishi_tupian1.jpg', 1, '未签到', '未签退', '2025-04-12 15:25:49', '', '226001617', 'djc', '18067193356', NULL);
INSERT INTO `yuyuexinxi` VALUES (1744442758364, '2025-04-12 15:25:57', 21, '1744442754819', '大自习室', 'upload/zixishi_tupian1.jpg', 28, '未签到', '未签退', '2025-04-12 15:25:56', '', '226001617', 'djc', '18067193356', NULL);
INSERT INTO `yuyuexinxi` VALUES (1744442764225, '2025-04-12 15:26:03', 21, '1744442760909', '大自习室', 'upload/zixishi_tupian1.jpg', 22, '已签到', '已签退', '2025-04-12 15:26:02', '', '226001617', 'djc', '18067193356', NULL);
INSERT INTO `yuyuexinxi` VALUES (1744442877353, '2025-04-12 15:27:57', 21, '1744442874786', '大自习室', 'upload/zixishi_tupian1.jpg', 1, '已签到', '已签退', '2025-04-12 15:27:56', '', '226001621', 'ftz', '18067193356', NULL);

-- ----------------------------
-- Table structure for zixishi
-- ----------------------------
DROP TABLE IF EXISTS `zixishi`;
CREATE TABLE `zixishi`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `mingcheng` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '名称',
  `tupian` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '图片',
  `guimo` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '规模',
  `zuowei` int NULL DEFAULT NULL COMMENT '座位',
  `weizhi` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '位置',
  `sheshi` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '设施',
  `keyueshijian` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '可约时间',
  `shifouyouke` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '是否有课',
  `xiangqing` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '详情',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '自习室' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of zixishi
-- ----------------------------
INSERT INTO `zixishi` VALUES (21, '2023-03-08 10:25:42', '大自习室', 'upload/zixishi_tupian1.jpg,upload/zixishi_tupian2.jpg,upload/zixishi_tupian3.jpg', '大型', 50, '1-203', '设施1', '可约时间1', '否', '<p>大型自习室</p>');
INSERT INTO `zixishi` VALUES (22, '2023-03-08 10:25:42', '图书馆', 'upload/zixishi_tupian2.jpg,upload/zixishi_tupian3.jpg,upload/zixishi_tupian4.jpg', '大型', 100, '图书馆', '设施2', '每天8：00至21：00，周一闭馆', '是', '<p>图书馆</p>');
INSERT INTO `zixishi` VALUES (23, '2023-03-08 10:25:42', '北区三号楼', 'upload/zixishi_tupian3.jpg,upload/zixishi_tupian4.jpg,upload/zixishi_tupian5.jpg', '大型', 40, '北区三号楼', '设施3', '每天8：00至21：00', '是', '<p>常常有课</p>');
INSERT INTO `zixishi` VALUES (24, '2023-03-08 10:25:42', '多媒体教室', 'upload/zixishi_tupian4.jpg,upload/zixishi_tupian5.jpg,upload/zixishi_tupian6.jpg', '小型', 20, '多媒体教室', '设施4', '每天8：00至21：00', '是', '<p>预约人数较多，请提前预约</p>');
INSERT INTO `zixishi` VALUES (25, '2023-03-08 10:25:42', '北区2号楼', 'upload/zixishi_tupian5.jpg,upload/zixishi_tupian6.jpg,upload/zixishi_tupian7.jpg', '中型', 80, '北区2号楼', '设施5', '每天8：00至21：00', '是', '<p>常常有课，请注意课表</p>');
INSERT INTO `zixishi` VALUES (26, '2023-03-08 10:25:42', '北区机房', 'upload/zixishi_tupian6.jpg,upload/zixishi_tupian7.jpg,upload/zixishi_tupian8.jpg', '大型', 90, '北区机房', '设施6', '每天8：00至18：00', '是', '<p>请注意可预约时间</p>');
INSERT INTO `zixishi` VALUES (27, '2023-03-08 10:25:42', 's2s', 'upload/zixishi_tupian7.jpg,upload/zixishi_tupian8.jpg,upload/zixishi_tupian9.jpg', '大型', 150, 's2s', '设施7', '每天6：00至23：00', '否', '<p>桌子较小</p>');
INSERT INTO `zixishi` VALUES (28, '2023-03-08 10:25:42', '宿舍楼自习室', 'upload/zixishi_tupian8.jpg,upload/zixishi_tupian9.jpg,upload/zixishi_tupian10.jpg', '大型', 100, '宿舍楼自习室', '设施8', '每天8：00至0：00', '否', '<p>请保持安静</p>');

SET FOREIGN_KEY_CHECKS = 1;
