import './constants.dart';

const comment_1 = const {
  'userName': 'Jaime Linda',
  'cp': '22',
  'text': 'Cannabis should not be legalized because it is harmful to the brain',
  'score': '81',
};

const comment_2 = const {
  'userName': 'Jesus Marcos',
  'cp': '9.2k',
  'text': 'Cannabis will increase tax revenue, which can help fund more oscial programs',
  'score': '920',
};

const comment_3 = const {
  'userName': 'Jaime Linda',
  'cp': '101k',
  'text': 'There is no evidence of a cannabis caused death.',
  'score': '2.2k',
};

const comments = const [comment_1, comment_2, comment_3];

const activity_0 = const {
  'userName': 'Sharon Gomez',
  'cp': '1.1k',
  'cabildoName': 'chile-cannabis',
  'title': 'Legalize Cannabis',
  'type': ACTIVITY_PROPOSAL,
  'text':
      'Cannabis should be legalized because it offers very few negative effects to society, and it is an essential medicine for a lot of people',
  'pingNum': '22.1k',
  'commentNum': '1.1k',
  'dateTime': '5 horas',
  'comments': comments,
  'score': '12.2k',
};

const activity_1 = const {
  'userName': 'Alonso Escalante',
  'cp': '5.2k',
  'cabildoName': 'Freedom Chile',
  'title': 'Remove the President',
  'type': ACTIVITY_DISCUSS,
  'text':
      'The president should be removed from office as he is unfit to lead the country. He does not represent the ideas of Chile',
  'pingNum': '15.2k',
  'commentNum': '800',
  'dateTime': '1 dia',
  'comments': comments,
  'score': '45.1k',
};

const activity_2 = const {
  'userName': 'Julia Maria',
  'cp': '208',
  'cabildoName': 'santiago-macul',
  'title': 'Should people have guns?',
  'type': ACTIVITY_POLL,
  'text': '',
  'pingNum': '200',
  'commentNum': '55',
  'dateTime': '1 semana',
  'comments': comments,
  'score': '2.2k',
};

const activity_3 = const {
  'userName': 'Julio Aregano',
  'cp': '60k',
  'cabildoName': 'all',
  'title': 'The status of healthcare',
  'type': ACTIVITY_DISCUSS,
  'text':
      'What do you think about free healthcare in Chile? It should be paid for by taxes',
  'pingNum': '10.2k',
  'commentNum': '9.1k',
  'dateTime': '6 dias',
  'comments': comments,
  'score': '800',
};

const activity_4 = const {
  'userName': 'Matteo Jorge',
  'cp': '20',
  'cabildoName': 'Freedom Chile',
  'title': 'Police illegally arrest 2 people',
  'type': ACTIVITY_DISCUSS,
  'text':
    'The police illegally detained two teenagers in Santiago at a protest last Sunday. They were peacefully protesting at Civic Square.',
  'pingNum': '4.9k',
  'commentNum': '42',
  'dateTime': '6 horas',
  'comments': comments,
  'score': '9.9k',
};

const activity_5 = const {
  'userName': 'Gloria Iglesias',
  'cp': '900',
  'cabildoName': 'santiago-chile',
  'title': 'Public education should be free',
  'type': ACTIVITY_POLL,
  'text': '',
  'pingNum': '1.1k',
  'commentNum': '271',
  'dateTime': '2 dias',
  'comments': comments,
  'score': '599',
};

const FEED_DATA = const [activity_3, activity_1, activity_2, activity_4, activity_0, activity_2, activity_5];