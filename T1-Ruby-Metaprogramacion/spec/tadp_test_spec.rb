require 'rspec'
require_relative '../src/tad_spec'

describe 'TADSPEC tests' do
  before do
    class A
      attr_accessor :hello, :o

      def initialize
        @hello = 25
        @o = 'holas'
      end

      def hola?
        true
      end

      def testear_que_gral
        a = A.new
        a.deberia tener_hello 25
        a.deberia tener_hello 25
        a.deberia tener_hello 25
        1.deberia ser 1
        1.deberia ser uno_de_estos [1, 2, 3]
        1.deberia ser uno_de_estos 1, 2, 3
        a.deberia tener_hello mayor_a 5
        a.deberia tener_hello menor_a 35
      end

      def testear_que_algo
        a = A.new
        proc { a.hoalslafls }.deberia explotar_con NoMethodError
      end
    end
  end

    class B
    attr_accessor :hello, :o

    def initialize
      @hello = 25
      @o = 'holas'
    end

    def hola?
      true
    end

    def testear_que_holis
      b = A.new
      b.deberia ser_hola?
    end

    def testear_que_sea_mayor
      b = A.new
      b.hello.deberia ser mayor_a 15
    end

    def testear_que_sea_menor
      b = A.new
      b.hello.deberia ser menor_a 60
    end

    def testear_que_ande_el_ser
      7.deberia ser 7
    end

    end

  class Persona
    attr_accessor :edad
    def initialize (algo)
      self.edad = algo
    end

    def viejo?
      edad > 29
    end
  end

  it 'test_sencillo ' do
    expect(TADsPec.testear.inject(true, :&)).to eq(true)
  end

  it 'testear solo la unit que pido' do
    expect(TADsPec.testear(A)).to eq([true,true])
  end

  it 'testear solo la unit que pido con el metodo que pido' do
    expect(TADsPec.testear(A, :testear_que_algo)).to eq([true])
  end

  it 'testear mayor_a' do
    expect(TADsPec.testear(B, :testear_que_sea_mayor)).to eq([true])
  end

  it 'testear menor_a' do
    expect(TADsPec.testear(B, :testear_que_sea_menor)).to eq([true])
  end

  it 'testear ser' do
    expect(TADsPec.testear(B, :testear_que_ande_el_ser)).to eq([true])
  end

  it 'testear entender' do
    class Holis
      def testear_que_pipipi
        leandro = Persona.new(15)
        leandro.deberia entender :viejo? # pasa
        leandro.deberia entender :class
      end
    end

    expect(TADsPec.testear(Holis, :testear_que_pipipi)).to eq([true])

  end

  it 'testear mock' do
    class PersonaHome
      def todas_las_personas
        # Este metodo consume un servicio web que consulta una base de datos
      end

      def personas_viejas
        todas_las_personas.select (&:viejo?)
      end

    end

    class PersonaHomeTests
      def testear_que_personas_viejas_trae_solo_a_los_viejos
        nico = Persona.new(30)
        axel = Persona.new(30)
        lean = Persona.new(22)

        PersonaHome.mockear :todas_las_personas do
          [nico, axel, lean]
        end

        viejos = PersonaHome.new.personas_viejas
        viejos.deberia ser [nico, axel]
      end
    end

    expect(TADsPec.testear(PersonaHomeTests)).to eq([true])
    
  end

  it 'testear spy' do
    class PersonaTest
      def testear_que_se_use_la_edad2
        pato = Persona.new(23)
        pato = espiar(pato)
        pato.viejo?
        pato.fran 1
        pato.deberia haber_recibido(:edad)
        # pasa: edad se llama durante la ejecucion de viejo?
        pato.deberia haber_recibido(:edad).veces(1)
        # pasa: edad se recibio exactamente 1 vez.
        pato.deberia haber_recibido(:viejo?).con_argumentos
        pato.deberia haber_recibido(:fran).con_argumentos(1)
      end
    end

    expect(TADsPec.testear(PersonaTest)).to eq([true])

  end

  it 'testear que falla' do
    class PersonaTestecito
      def testear_que_son_las_4_am
        fran = Persona.new(5)
        fran.deberia ser_viejo?
      end
    end

    expect(TADsPec.testear(PersonaTestecito)).to eq([false])

  end

  it 'testear que rompe todo a la mierda' do
    class PersonaTestecitos
      def testear_que_son_las_4_am
        fran = Persona.new 15
        fran.deberia ser_puto?
      end
    end

    expect(TADsPec.testear(PersonaTestecitos)).to eq([nil])

  end
end