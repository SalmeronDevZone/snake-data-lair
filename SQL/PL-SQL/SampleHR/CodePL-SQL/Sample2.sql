CREATE OR REPLACE TYPE cuenta_bancaria AS OBJECT (
    numero_cuenta VARCHAR2(20),
    saldo NUMBER,

    -- Método para depositar dinero en la cuenta
    MEMBER PROCEDURE depositar(monto NUMBER) IS
    BEGIN
        saldo := saldo + monto;
        DBMS_OUTPUT.PUT_LINE('Se ha depositado ' || monto || ' en la cuenta. Nuevo saldo: ' || saldo);
    END;

    -- Método para retirar dinero de la cuenta
    MEMBER PROCEDURE retirar(monto NUMBER) IS
    BEGIN
        IF saldo >= monto THEN
            saldo := saldo - monto;
            DBMS_OUTPUT.PUT_LINE('Se ha retirado ' || monto || ' de la cuenta. Nuevo saldo: ' || saldo);
        ELSE
            DBMS_OUTPUT.PUT_LINE('Saldo insuficiente para realizar el retiro.');
        END IF;
    END;

    -- Método para obtener el saldo actual de la cuenta
    MEMBER FUNCTION obtener_saldo RETURN NUMBER IS
    BEGIN
        RETURN saldo;
    END;
);
/
