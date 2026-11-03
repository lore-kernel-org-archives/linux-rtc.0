Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793746247;
	b=DmLyuBlGwWTGdH5jGEtbXEk6O/10QVCkfNH65HE8gSUMMMrUUSdgZ0mthv1rj3d0UE+6
	 Xyw92mfLpVTEJwLStw9L3m0VyCEsuxOwgTz4LkOcSoceSYZ87Fm4tooejNiQaxzYa9Xnc
	 VtylmlQ2xYEix8Nz+4V1FMskBKxP5MSGwh9Kb3kd+9zBt0V7LdH0S4ANNlbKdffdeDpJL
	 1+Fgs4PWcg+GEy4Ur2GgkeWdViGQvwRQHaOqbxtXSgcAVHA/U98e1loFQBZ4NKNl9C46O
	 Miq1DgsjEBziCZIO8lfe7SG74XAWSB2PKuAkimoPTWZT3ZHs2S+UeDbBouf316lHW7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793746247;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LlFo2ep2P1KPlq/R+Mfiz9sgo8hglVDiwuMn3YrPXds=;
	b=g1fXtcEjUhUlIu+dJM2n+nmsJ4w8Gs1d57c6FjywgA0mgYby8FBfI25vdq3dNXLoxkak
	 fGVr3juzmSXLlIb4cQsb4j2E6cG7D/oaCSZjIuPloQzMCdBw/oIyl7wJHygycpjfSrdiP
	 JLUDDVqa2JtFsY5NqxD3tJURNSiR8OMctVjSK9HEhOv9Kf/2J55N+XwdCTacCI6A7a9zT
	 h6fhfutUlz4ym6+ppRntEix8dmgsyuAleLnorMxSLKeQI8BeTc44VIRBIWJPrPkp9akAL
	 tSvAesSCrxVX25oFvSOsgROuuvuKTu7WcH1LTqAmXoV3g80OkL5GLgwckKi1nJM94sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="o2/V0RJ2";
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13D2606A31B
	for <linux-rtc@vger.kernel.org>; Tue,  3 Nov 2026 22:50:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C13D2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o2/V0RJ2
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1a2761c69fbso325083c88.0
        for <linux-rtc@vger.kernel.org>; Tue, 03 Nov 2026 14:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793746246; x=1794351046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LlFo2ep2P1KPlq/R+Mfiz9sgo8hglVDiwuMn3YrPXds=;
        b=o2/V0RJ2Hi3g+gmEbMtNuOkrlTrbVO6X1S5M5X4R8Dz45BdmpG3iBjItK2kT9uQTzA
         Ih4cMV0rdNcIYoCS7aaFZjZns+KmciLD1fDDE6x88ttWG6WM1I6v81zq53bgsfNMF5pS
         WSDCc8SF+NY6Y7iMU+iA9Wd8x9oECfFF7pY7noqOtGM4Rw1L/JButaOH1WYsAyFPLT5M
         F1Ekmr+NaispYfZ9ypQk2Rbwne1ODljAN7ihhxbl/HNgQFn+QxhlKWw0/AIb+xXCrWmx
         7SLCN0CQOfemq9tkuUXFUwv1EVTEBrDnmBB5yul0dd1e7uhRiBXERAlWuehcSRmGW44J
         P7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793746246; x=1794351046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LlFo2ep2P1KPlq/R+Mfiz9sgo8hglVDiwuMn3YrPXds=;
        b=lJeoqL7FsBuI/7ry6uuc6CyYiIsJvCvsaTKGTll0LUvkLyliOmdSFDxI7DmkAlIZsa
         5aXaUhMAnbUd+AqsXxmx9QRkpIIqF40sNWobmGsy7stnEny4jf2TA63Y8J/7ZbMoTuNH
         FpQpmVlq3C74Pj3fjeeA/o5HolspHth1vv9tadY5KH/GBfird573V+yXaf7jqBK740aW
         eQinVmhHxreG4yWmMO8Q5K59yzILaUymJ0F4t1pxFuL2fv7BK8apF2o+RDjgez4X5jfg
         qyqzcRBndwLcSOwX5u2uu4H7ROr+inqc5l+5s5KU/dgFqAHw2VRUWK2WHDwK8UN7+WFv
         qpmw==
X-Forwarded-Encrypted: i=1; AKwUvBwk9IHDNc+1TMd6NkMI+7chLkZ2wYXDnaL65unMNOQ4FoWJ2tIxKFudV6xHviCriZ+dj5XvdNQtx4Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z8xRB0GTVvf9qIKkx3ffHsumQYTA6qt7bUYTUL36yPw3gwiK7yM
	EUh3dJH68Sohb24iyAiYq1K49PGte2hgy7nZRoQDlnT8UzAYQrlMbAJSPrNyDQ==
X-Gm-Gg: AYBFou1cJjOUQbeSl4heaDDvZb6zaaNWHpnL1mGt6VKCWpoeMapmBh656ftdh4GBlwS
	P6f/bmYvNFGzxMsz5Na8y54Esw5AK3TgFjqUu1nYi07ARCMVSvWyTGehqlZS4hZ8t4DtH/QfSVe
	JWDn44lfjCwVA08plXwiufVS+EEgbW38xejobvV12c1FddFiOpof1rbBuE+GhmmFucukW57ZbJU
	gUmcyUw/ZnD1XkoFFiwRvL1j6+grnM/Fh4ZC5sdPcWicCTUamugLtdcJRmmbSxh6SC66nMXm1c4
	2JNtOR5jsIBBV2GMjHSK6uzyU1UVJiKl5QT2kxtmsMai++mGmfoAZ/gt2zXs/iK5qa++Re04ePx
	BuLdlf9CLoIpa/6wK8GhhYyVF9LEE4T1c8RbBAlySYpaiqMLVV5CnMLgep73EI4y+QavqzrF6Lu
	TuTWXgvnYUhZ5Yl060CpcJwZAUlwBAQgEzOs9err0/OBdbtJzUpSk+d40+Z+ltdUasjKBezRLc4
	JWhoM6S8SuJFA7MHKcwl4SA4SAh8/19R8s3aJFz8fo+IX9tNGrxjX09s8mYQ3vWTPw5EhYPVtaR
	+E1ErivI
X-Received: by 2002:a05:701b:4187:20b0:19b:1202:77f8 with SMTP id a92af1059eb24-1ac5bf91695mr23676431c88.32.1793746245851;
        Tue, 03 Nov 2026 14:50:45 -0800 (PST)
Received: from eldorado ([2600:8802:b00:1f88::287])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c4f83fsm2781161c88.17.2026.11.03.14.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:50:43 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: macro@orcam.me.uk,
	Florian Fainelli <f.fainelli@gmail.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-rtc@vger.kernel.org (open list:REAL TIME CLOCK (RTC) SUBSYSTEM)
Subject: [PATCH RFC] rtc: m41t80: Support SMBus adapters without I2C block transfers
Date: Tue,  3 Nov 2026 14:50:26 -0800
Message-ID: <20261103225027.1248035-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The M41T81 on the Broadcom BCM91250E (Sentosa) is connected to the
SiByte SMBus controller. The controller supports SMBus byte and word
transactions, but not the I2C block transfers required by rtc-m41t80,
so the driver refuses to probe.

Use the I2C core's block-read emulation and provide a byte-write
fallback, retaining native block transfers when the adapter supports
them. Propagate transfer errors and reject short reads.

Individual byte or word reads do not latch the complete clock register
set. Recheck seconds after reading the time on adapters without block
reads and retry up to three times if the clock rolled over. Return
-EAGAIN if a consistent sample cannot be obtained.

Maciej W. Rozycki proposed SMBus-only support for this RTC family in
2008. The same SiByte limitation was discussed again in 2018, including
register latching, seconds rechecks and a possible regmap conversion.
This change revisits that approach using the current I2C helpers.

RTC access and date retention across a reboot were verified on a
BCM91250E. Host tests with mocked SMBus transfers covered native and
fallback paths, rollover retries, short reads and transfer errors.
Alarm operation and retention after a power-cycle were not tested.

Link: https://lkml.rescloud.iu.edu/hypermail/linux/kernel/0805.1/1778.html
Link: https://lkml.rescloud.iu.edu/1811.1/07408.html
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/rtc/rtc-m41t80.c | 65 +++++++++++++++++++++++++++++++++-------
 1 file changed, 54 insertions(+), 11 deletions(-)

diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
index 1385cb43864b..23d02b95a606 100644
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -188,11 +188,41 @@ static irqreturn_t m41t80_handle_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+/* Some SMBus adapters only support byte and word transactions. */
+static int m41t80_read_regs(struct i2c_client *client, u8 reg, u8 len, u8 *buf)
+{
+	int ret;
+
+	ret = i2c_smbus_read_i2c_block_data_or_emulated(client, reg, len, buf);
+	if (ret < 0)
+		return ret;
+
+	return ret == len ? ret : -EIO;
+}
+
+static int m41t80_write_regs(struct i2c_client *client, u8 reg, u8 len,
+			    const u8 *buf)
+{
+	int i, ret;
+
+	if (i2c_check_functionality(client->adapter,
+				    I2C_FUNC_SMBUS_WRITE_I2C_BLOCK))
+		return i2c_smbus_write_i2c_block_data(client, reg, len, buf);
+
+	for (i = 0; i < len; i++) {
+		ret = i2c_smbus_write_byte_data(client, reg + i, buf[i]);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int m41t80_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	unsigned char buf[8];
-	int err, flags;
+	int err, flags, tries;
 
 	flags = i2c_smbus_read_byte_data(client, M41T80_REG_FLAGS);
 	if (flags < 0)
@@ -203,12 +233,25 @@ static int m41t80_rtc_read_time(struct device *dev, struct rtc_time *tm)
 		return -EINVAL;
 	}
 
-	err = i2c_smbus_read_i2c_block_data(client, M41T80_REG_SSEC,
-					    sizeof(buf), buf);
-	if (err < 0) {
-		dev_dbg(&client->dev, "Unable to read date\n");
-		return err;
+	/* Byte reads do not latch the clock registers across a rollover. */
+	for (tries = 0; tries < 3; tries++) {
+		err = m41t80_read_regs(client, M41T80_REG_SSEC,
+				       sizeof(buf), buf);
+		if (err < 0)
+			return err;
+
+		if (i2c_check_functionality(client->adapter,
+					    I2C_FUNC_SMBUS_READ_I2C_BLOCK))
+			break;
+
+		err = i2c_smbus_read_byte_data(client, M41T80_REG_SEC);
+		if (err < 0)
+			return err;
+		if ((err & 0x7f) == (buf[M41T80_REG_SEC] & 0x7f))
+			break;
 	}
+	if (tries == 3)
+		return -EAGAIN;
 
 	tm->tm_sec = bcd2bin(buf[M41T80_REG_SEC] & 0x7f);
 	tm->tm_min = bcd2bin(buf[M41T80_REG_MIN] & 0x7f);
@@ -259,7 +302,7 @@ static int m41t80_rtc_set_time(struct device *dev, struct rtc_time *in_tm)
 		buf[M41T80_REG_WDAY] |= (val & 0xf0);
 	}
 
-	err = i2c_smbus_write_i2c_block_data(client, M41T80_REG_SSEC,
+	err = m41t80_write_regs(client, M41T80_REG_SSEC,
 					     sizeof(buf), buf);
 	if (err < 0) {
 		dev_dbg(&client->dev, "Unable to write to date registers\n");
@@ -374,7 +417,7 @@ static int m41t80_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	}
 
 	/* Write the alarm */
-	err = i2c_smbus_write_i2c_block_data(client, M41T80_REG_ALARM_MON,
+	err = m41t80_write_regs(client, M41T80_REG_ALARM_MON,
 					     5, alarmvals);
 	if (err)
 		return err;
@@ -397,7 +440,7 @@ static int m41t80_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	u8 alarmvals[5];
 	int flags, ret;
 
-	ret = i2c_smbus_read_i2c_block_data(client, M41T80_REG_ALARM_MON,
+	ret = m41t80_read_regs(client, M41T80_REG_ALARM_MON,
 					    5, alarmvals);
 	if (ret != 5)
 		return ret < 0 ? ret : -EIO;
@@ -906,9 +949,9 @@ static int m41t80_probe(struct i2c_client *client)
 	struct m41t80_data *m41t80_data = NULL;
 	bool wakeup_source = false;
 
-	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_I2C_BLOCK |
+	if (!i2c_check_functionality(client->adapter,
 				     I2C_FUNC_SMBUS_BYTE_DATA)) {
-		dev_err(&adapter->dev, "doesn't support I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_I2C_BLOCK\n");
+		dev_err(&adapter->dev, "doesn't support I2C_FUNC_SMBUS_BYTE_DATA\n");
 		return -ENODEV;
 	}
 
-- 
2.53.0

