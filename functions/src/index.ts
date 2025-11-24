import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import axios from 'axios';

admin.initializeApp();

const ASTROLOGY_API_KEY = functions.config().astrology?.api_key || 'YOUR_API_KEY';
const ASTROLOGY_API_URL = 'https://api.vedicrishiastro.com/v1';

interface HoroscopeData {
  zodiacSign: string;
  date: admin.firestore.Timestamp;
  prediction: string;
  love?: string;
  career?: string;
  health?: string;
  finance?: string;
  family?: string;
  mood?: string;
  luck?: string;
  spirituality?: string;
  loveRating?: number;
  moodRating?: number;
  careerRating?: number;
  healthRating?: number;
  luckRating?: number;
  luckyNumber: number;
  luckyColor: string;
  luckyTime?: string;
  luckyDirection?: string;
  luckyStone?: string;
  dailyMantra?: string;
  affirmation?: string;
  bestActivity?: string;
  avoidToday?: string;
  planetaryHighlight?: string;
  planetaryInfluence?: { [key: string]: string };
  tithi?: string;
  nakshatra?: string;
  yoga?: string;
  karana?: string;
  rahuKalam?: string;
  gulikaKalam?: string;
  yamagandaKalam?: string;
  tarotCardName?: string;
  tarotCardMeaning?: string;
  tarotCardImageUrl?: string;
  morningEnergy?: number;
  afternoonEnergy?: number;
  eveningEnergy?: number;
  dateRange?: string;
  createdAt: admin.firestore.Timestamp;
  updatedAt: admin.firestore.Timestamp;
}

const zodiacSigns = [
  'Aries', 'Taurus', 'Gemini', 'Cancer', 'Leo', 'Virgo',
  'Libra', 'Scorpio', 'Sagittarius', 'Capricorn', 'Aquarius', 'Pisces'
];

const tarotCards = [
  { name: 'The Fool', meaning: 'New beginnings, innocence, spontaneity' },
  { name: 'The Magician', meaning: 'Manifestation, resourcefulness, power' },
  { name: 'The High Priestess', meaning: 'Intuition, sacred knowledge, divine feminine' },
  { name: 'The Empress', meaning: 'Femininity, beauty, nature, abundance' },
  { name: 'The Emperor', meaning: 'Authority, establishment, structure' },
  { name: 'The Hierophant', meaning: 'Spiritual wisdom, religious beliefs, conformity' },
  { name: 'The Lovers', meaning: 'Love, harmony, relationships, values alignment' },
  { name: 'The Chariot', meaning: 'Control, willpower, success, determination' },
  { name: 'Strength', meaning: 'Strength, courage, persuasion, influence' },
  { name: 'The Hermit', meaning: 'Soul searching, introspection, inner guidance' },
];

function getRandomTarotCard() {
  return tarotCards[Math.floor(Math.random() * tarotCards.length)];
}

function generateLuckyNumber(): number {
  return Math.floor(Math.random() * 100) + 1;
}

function generateLuckyColor(): string {
  const colors = [
    'Red', 'Blue', 'Green', 'Yellow', 'Orange', 'Purple',
    'Pink', 'Gold', 'Silver', 'White', 'Black', 'Teal'
  ];
  return colors[Math.floor(Math.random() * colors.length)];
}

function generateEnergyLevel(): number {
  return Math.floor(Math.random() * 10) + 1;
}

function generateRating(): number {
  return Math.floor(Math.random() * 5) + 1;
}

async function fetchHoroscopeFromAPI(zodiacSign: string, date: Date): Promise<any> {
  try {
    const response = await axios.get(
      `${ASTROLOGY_API_URL}/horoscope/daily`,
      {
        params: {
          sign: zodiacSign,
          date: date.toISOString().split('T')[0],
        },
        headers: {
          'Authorization': `Bearer ${ASTROLOGY_API_KEY}`,
        },
      }
    );
    return response.data;
  } catch (error) {
    console.error(`Error fetching horoscope for ${zodiacSign}:`, error);
    // Return mock data if API fails
    return generateMockHoroscopeData(zodiacSign);
  }
}

function generateMockHoroscopeData(zodiacSign: string): any {
  return {
    prediction: `Today brings new opportunities for ${zodiacSign}. Trust your instincts and embrace change.`,
    love: `Your relationships are highlighted today. Open communication will strengthen bonds.`,
    career: `Professional growth is on the horizon. Take initiative and showcase your talents.`,
    health: `Focus on wellness and balance. Listen to your body's needs.`,
    finance: `Financial decisions require careful consideration. Avoid impulsive spending.`,
    family: `Family connections bring joy and support. Spend quality time with loved ones.`,
    mood: `Your emotional state is balanced. Practice gratitude for inner peace.`,
    luck: `Fortune favors the bold. Take calculated risks today.`,
    spirituality: `Connect with your inner self through meditation or reflection.`,
  };
}

async function fetchPanchangData(date: Date): Promise<any> {
  try {
    // This would call a Panchang API
    // For now, return mock data
    return {
      tithi: 'Dwitiya',
      nakshatra: 'Rohini',
      yoga: 'Vajra',
      karana: 'Bava',
      rahuKalam: '07:30 - 09:00',
      gulikaKalam: '10:30 - 12:00',
      yamagandaKalam: '13:30 - 15:00',
    };
  } catch (error) {
    console.error('Error fetching Panchang data:', error);
    return {};
  }
}

export const fetchDailyHoroscopes = functions.pubsub
  .schedule('0 0 * * *') // Run daily at midnight UTC
  .timeZone('UTC')
  .onRun(async (context) => {
    const db = admin.firestore();
    const today = new Date();
    today.setHours(0, 0, 0, 0);

    console.log(`Fetching horoscopes for ${today.toISOString()}`);

    const batch = db.batch();
    let batchCount = 0;
    const MAX_BATCH_SIZE = 500;

    for (const zodiacSign of zodiacSigns) {
      try {
        // Check if horoscope already exists
        const existingQuery = await db
          .collection('horoscopes')
          .where('zodiacSign', '==', zodiacSign)
          .where('date', '==', admin.firestore.Timestamp.fromDate(today))
          .limit(1)
          .get();

        if (!existingQuery.empty) {
          console.log(`Horoscope for ${zodiacSign} already exists for ${today.toISOString()}`);
          continue;
        }

        // Fetch from API
        const apiData = await fetchHoroscopeFromAPI(zodiacSign, today);
        const panchangData = await fetchPanchangData(today);
        const tarotCard = getRandomTarotCard();

        const horoscopeData: HoroscopeData = {
          zodiacSign,
          date: admin.firestore.Timestamp.fromDate(today),
          prediction: apiData.prediction || generateMockHoroscopeData(zodiacSign).prediction,
          love: apiData.love,
          career: apiData.career,
          health: apiData.health,
          finance: apiData.finance,
          family: apiData.family,
          mood: apiData.mood,
          luck: apiData.luck,
          spirituality: apiData.spirituality,
          loveRating: generateRating(),
          moodRating: generateRating(),
          careerRating: generateRating(),
          healthRating: generateRating(),
          luckRating: generateRating(),
          luckyNumber: generateLuckyNumber(),
          luckyColor: generateLuckyColor(),
          luckyTime: `${Math.floor(Math.random() * 12) + 1}:${Math.floor(Math.random() * 60).toString().padStart(2, '0')} ${Math.random() > 0.5 ? 'AM' : 'PM'}`,
          luckyDirection: ['North', 'South', 'East', 'West', 'Northeast', 'Northwest', 'Southeast', 'Southwest'][Math.floor(Math.random() * 8)],
          luckyStone: ['Diamond', 'Ruby', 'Emerald', 'Sapphire', 'Pearl', 'Coral', 'Topaz', 'Amethyst'][Math.floor(Math.random() * 8)],
          dailyMantra: `Om ${zodiacSign} Namah`,
          affirmation: `I am aligned with the cosmic energy of ${zodiacSign} and embrace today's opportunities.`,
          bestActivity: ['Meditation', 'Creative Work', 'Exercise', 'Socializing', 'Learning', 'Planning'][Math.floor(Math.random() * 6)],
          avoidToday: ['Impulsive Decisions', 'Conflict', 'Overwork', 'Negativity', 'Procrastination'][Math.floor(Math.random() * 5)],
          planetaryHighlight: `${['Sun', 'Moon', 'Mars', 'Mercury', 'Jupiter', 'Venus', 'Saturn'][Math.floor(Math.random() * 7)]} is in favorable position`,
          planetaryInfluence: {
            Sun: 'Strong energy and vitality',
            Moon: 'Emotional balance and intuition',
            Mars: 'Action and determination',
          },
          tithi: panchangData.tithi,
          nakshatra: panchangData.nakshatra,
          yoga: panchangData.yoga,
          karana: panchangData.karana,
          rahuKalam: panchangData.rahuKalam,
          gulikaKalam: panchangData.gulikaKalam,
          yamagandaKalam: panchangData.yamagandaKalam,
          tarotCardName: tarotCard.name,
          tarotCardMeaning: tarotCard.meaning,
          tarotCardImageUrl: `https://images.unsplash.com/photo-${Math.floor(Math.random() * 1000000)}?w=400&h=600&fit=crop`,
          morningEnergy: generateEnergyLevel(),
          afternoonEnergy: generateEnergyLevel(),
          eveningEnergy: generateEnergyLevel(),
          dateRange: getZodiacDateRange(zodiacSign),
          createdAt: admin.firestore.Timestamp.now(),
          updatedAt: admin.firestore.Timestamp.now(),
        };

        const docRef = db.collection('horoscopes').doc();
        batch.set(docRef, horoscopeData);
        batchCount++;

        if (batchCount >= MAX_BATCH_SIZE) {
          await batch.commit();
          batchCount = 0;
        }

        console.log(`Queued horoscope for ${zodiacSign}`);
      } catch (error) {
        console.error(`Error processing ${zodiacSign}:`, error);
      }
    }

    if (batchCount > 0) {
      await batch.commit();
    }

    console.log(`Successfully fetched horoscopes for ${today.toISOString()}`);
    return null;
  });

function getZodiacDateRange(zodiacSign: string): string {
  const ranges: { [key: string]: string } = {
    'Aries': 'Mar 21 - Apr 19',
    'Taurus': 'Apr 20 - May 20',
    'Gemini': 'May 21 - Jun 20',
    'Cancer': 'Jun 21 - Jul 22',
    'Leo': 'Jul 23 - Aug 22',
    'Virgo': 'Aug 23 - Sep 22',
    'Libra': 'Sep 23 - Oct 22',
    'Scorpio': 'Oct 23 - Nov 21',
    'Sagittarius': 'Nov 22 - Dec 21',
    'Capricorn': 'Dec 22 - Jan 19',
    'Aquarius': 'Jan 20 - Feb 18',
    'Pisces': 'Feb 19 - Mar 20',
  };
  return ranges[zodiacSign] || '';
}

