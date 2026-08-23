Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1983B05A7
	for <linux-rtc@vger.kernel.org>; Sun, 23 Aug 2026 22:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787523226; cv=none; b=qm7vAG/Aj1M+pjn4xyLenKta8MSm4rvfsc38zhZMaKUyJ5ARKK1U1J2UDPsf35gaXNOiuvO0Z50EweiiLnV6HccSHUbfHxr2StZUeL6dfsPL+pR7p2IDK6kxFPLRWCXFd8XMWrvvOAXL2DdvVbb4Gt63n8r2aUx+UM+mBQFfILE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787523226; c=relaxed/simple;
	bh=+H2irxO+vHnzaAdlynVOXFQUg0FvVTr6w7w7CRmDpRM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q/ahqqp21aOcjRNRjXLh2u5tlWaSGW11XiaI4ijswdv+yW42eCL1H23oOVDqP6hJGD9zC/6PhkELDCb4hmxwhQGM5Yi9xwxkRRgp3wwK2XhPsR4iv3tSDWMSo1EzbZOTz6Bo4XchJHrZamaJxDGlZdLUA3XnOOu4AFwK3h8CDn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=VxXXPeDl; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="VxXXPeDl"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id DC138240105
	for <linux-rtc@vger.kernel.org>; Mon, 24 Aug 2026 00:13:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1787523220;
	bh=GnokgzqUMxUqnPy3Su36XIkMvowfVrGKX4GcN4Lsg7M=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=VxXXPeDluvzgsIR3+zcYtmfPLwkT+vUb2uO1csAaogfk6dtz0/GpZUxQ6XZBeY4qs
	 KQ1pdehvGlRE+Giv8Hobikt/Pa0csRYQC7wia+fvYmYnllmEkmPYnGLmKkvz5Cpwly
	 wB0BSegpipt9hRwjdTxaVmTOtGdWjPaw9MmuPQCxTYq/oxXHHNNnY/2uIztxNmsutZ
	 n9vl1YAZHWTdfg0t+g8TtPkbro0FpeEQf6Kd27sTUzJMOAGGgJZlxxa1+Lweunv+tH
	 rRjAwpbMzzjyCwF0H321zaTg1E2YeiEc+F8rJ3hP/IrEsoPhXHhT3+cf1Wrm+XjAwP
	 5vegqycdeUHEA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hSpGV5qLxz9rxG;
	Mon, 24 Aug 2026 00:13:38 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Date: Sun, 23 Aug 2026 22:13:40 +0000
Subject: [PATCH v6 4/6] rtc: s35390a: Read 24-hour mode on access
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-rtc_s35390a_int1-v6-4-df96569e3412@posteo.de>
References: <20260824-rtc_s35390a_int1-v6-0-df96569e3412@posteo.de>
In-Reply-To: <20260824-rtc_s35390a_int1-v6-0-df96569e3412@posteo.de>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, 
 Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Michael Langer <michael.brainbug.langer@googlemail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Linus Walleij <linusw@kernel.org>, 
 Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Markus Probst <markus.probst@posteo.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=8251;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=+H2irxO+vHnzaAdlynVOXFQUg0FvVTr6w7w7CRmDpRM=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqi3CLQAL4UnksFVtvI/3PPr5/6yPKycthgTc6o
 FYLAOT0CXqJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCaotwixsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9IYcg/9HVknlcGy+YPFNVa7OUrL+hmUhiJY1gI
 hUu1vtrhhyLnNF6y5+zRnCdWvCOUka9G3fqrqm3Y0jpWH37pB0Ej/eVlH3g4jElGO7MRoYF/YOd
 jAx318zHQ3PLKx4LUZeW7KZqpGVlr3yxd2igWRziBtEuIOmpfX3o5zjTYLonPsMwyCXbugeIK1O
 v1qrFeZpCijOS88GresgemG5nTr4oQApyfBsUJ92fBRYbrotd6j1YU7wrtKHR6e6eNRZvROH1Nm
 FDuB2xXCSuslXKKs0vXg2yglS10/Txqeh9HqG55CFxoPCxReJw5fvAnGN0j7MDqzzF030BeA8ji
 C6PiRxhJwl2fMKLr+jLODc35wt6YbsQoluofn8XOlx/X1ICRxEMxs+t9ANTGMRXpQM6vUAIxgLO
 tx1oRK5cWR3VbnvZD4gRIIOuW+P2/vucs0b8OjbgoRa44ewSOw8s5Bs53Z4VlaPCnaTlx4rFZKN
 r3xhkdiwF1TbyXgpq6MAr/u6tEiWd2hjB5td+//CsZhUD2sqEUQHETCSBaiM8ATvCE22UHr1SAb
 FVYio7UmvYVs8EKSzm3E6IuHYfoBVa9bXLB1m0mDFpOqoOgufAZZpDxhF6I1ELsJ1NJa+S6NFBn
 RZrBrvkv+AS8EFkxlEB6FoipIBteAvvoia5GK6pzHnD6/Cc+n/9U=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=xsFNBGiDvXgBEADAXUceKafpl46S35UmDh2wRvvx+UfZbcTjeQOlSwKP7YVJ4JOZrVs93qReNLkO
  WguIqPBxR9blQ4nyYrqSCV+MMw/3ifyXIm6Pw2YRUDg+WTEOjTixRCoWDgUj1nOsvJ9tVAm76Ww+
  /pAnepVRafMID0rqEfD9oGv1YrfpeFJhyE2zUw3SyyNLIKWD6QeLRhKQRbSnsXhGLFBXCqt9k5JA
  RhgQof9zvztcCVlT5KVvuyfC4H+HzeGmu9201BVyihJwKdcKPq+n/aY5FUVxNTgtI9f8wIbmfAja
  oT1pjXSp+dszakA98fhONM98pOq723o/1ZGMZukyXFfsDGtA3BB79HoopHKujLGWAGskzClwTjRQ
  xBqxh/U/lL1pc+0xPWikTNCmtziCOvv0KA0arDOMQlyFvImzX6oGVgE4ksKQYbMZ3Ikw6L1Rv1J+
  FvN0aNwOKgL2ztBRYscUGcQvA0Zo1fGCAn/BLEJvQYShWKeKqjyncVGoXFsz2AcuFKe1pwETSsN6
  OZncjy32e4ktgs07cWBfx0v62b8md36jau+B6RVnnodaA8++oXl3FRwiEW8XfXWIjy4umIv93tb8
  8ekYsfOfWkTSewZYXGoqe4RtK80ulMHb/dh2FZQIFyRdN4HOmB4FYO5sEYFr9YjHLmDkrUgNodJC
  XCeMe4BO4iaxUQARAQABzRdtYXJrdXMucHJvYnN0QHBvc3Rlby5kZcLBkQQTAQgAOxYhBIJ0GMT0
  rFjncjDEczR2H/jnrUPSBQJog714AhsDBQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheAAAoJEDR2
  H/jnrUPSgdkQAISaTk2D345ehXEkn5z2yUEjaVjHIE7ziqRaOgn/QanCgeTUinIv6L6QXUFvvIfH
  1OLPwQ1hfvEg9NnNLyFezWSy6jvoVBTIPqicD/r3FkithnQ1IDkdSjrarPMxJkvuh3l7XZHo49GV
  HQ8i5zh5w4YISrcEtE99lJisvni2Jqx7we5tey9voQFDyM8jxlSWv3pmoUTCtBkX/eKHJXosgsuS
  B4TGDCVPOjla/emI5c9MhMG7O4WEEmoSdPbmraPw66YZD6uLyhV4DPHbiDWRzXWnClHSyjB9rky9
  lausFxogvu4l9H+KDsXIadNDWdLdu1/enS/wDd9zh5S78rY2jeXaG4mnf4seEKamZ7KQ6FIHrcyP
  ezdDzssPQcTQcGRMQzCn6wP3tlGk7rsfmyHMlFqdRoNNv+ZER/OkmZFPW655zRfbMi0vtrqK2Awm
  9ggobb1oktfd9PPNXMUY+DNVlgR2G7jLnenSoQausLUm0pHoNE8TWFv851Y6SOYnvn488sP1Tki5
  F3rKwclawQFHUXTCQw+QSh9ay8xgnNZfH+u9NY7w3gPoeKBOAFcBc2BtzcgekeWS8qgEmm2/oNFV
  G0ivPQbRx8FjRKbuF7g3YhgNZZ0ac8FneuUtJ2PkSIFTZhaAiC0utvxk0ndmWFiW4acEkMZGrLaM
  L2zWNjrqwsD2zsFNBGiDvXgBEADCXQy1n7wjRxG12DOVADawjghKcG+5LtEf31WftHKLFbp/HArj
  BhkT6mj+CCI1ClqY+FYU5CK/s0ScMfLxRGLZ0Ktzawb78vOgBVFT3yB1yWBTewsAXdqNqRooaUNo
  8cG/NNJLjhccH/7PO/FWX5qftOVUJ/AIsAhKQJ18Tc8Ik73v427EDxuKb9mTAnYQFA3Ev3hAiVbO
  6Rv39amVOfJ8sqwiSUGidj2Fctg2aB5JbeMln0KCUbTD1LhEFepeKypfofAXQbGwaCjAhmkWy/q3
  IT1mUrPxOngbxdRoOx1tGUC0HCMUW1sFaJgQPMmDcR0JGPOpgsKnitsSnN7ShcCr1buel7vLnUMD
  +TAZ5opdoF6HjAvAnBQaijtK6minkrM0seNXnCg0KkV8xhMNa6zCs1rq4GgjNLJue2EmuyHooHA4
  7JMoLVHcxVeuNTp6K2+XRx0Pk4e2Lj8IVy9yEYyrywEOC5XRW37KJjsiOAsumi1rkvM7QREWgUDe
  Xs0+RpxI3QrrANh71fLMRo7LKRF3Gvw13NVCCC9ea20P4PwhgWKStkwO2NO+YJsAoS1QycMi/vKu
  0EHhknYXamaSV50oZzHKmX56vEeJHTcngrM8R1SwJCYopCx9gkz90bTVYlitJa5hloWTYeMD7FNj
  Y6jfVSzgM/K4gMgUNDW/PPGeMwARAQABwsF2BBgBCAAgFiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IF
  AmiDvXgCGwwACgkQNHYf+OetQ9LHDBAAhk+ab8+WrbS/b1/gYW3q1KDiXU719nCtfkUVXKidW5Ec
  Idlr5HGt8ilLoxSWT2Zi368iHCXS0WenGgPwlv8ifvB7TOZiiTDZROZkXjEBmU4nYjJ7GymawpWv
  oQwjMsPuq6ysbzWtOZ7eILx7cI0FjQeJ/Q2baRJub0uAZNwBOxCkAS6lpk5Fntd2u8CWmDQo4SYp
  xeuQ+pwkp0yEP30RhN2BO2DXiBEGSZSYh+ioGbCHQPIV3iVj0h6lcCPOqopZqyeCfigeacBI0nvN
  jHWz/spzF3+4OS+3RJvoHtAQmProxyGib8iVsTxgZO3UUi4TSODeEt0i0kHSPY4sCciOyXfAyYoD
  DFqhRjOEwBBxhr+scU4C1T2AflozvDwq3VSONjrKJUkhd8+WsdXxMdPFgBQuiKKwUy11mz6KQfcR
  wmDehF3UaUoxa+YIhWPbKmycxuX/D8SvnqavzAeAL1OcRbEI/HsoroVlEFbBRNBZLJUlnTPs8ZcU
  4+8rq5YX1GUrJL3jf6SAfSgO7UdkEET3PdcKFYtS+ruV1Cp5V0q4kCfI5jk25iiz8grM2wOzVSsc
  l1mEkhiEPH87HP0whhb544iioSnumd3HJKL7dzhRegsMizatupp8D65A2JziW0WKopa1iw9fti3A
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

Instead of reading if the 24-hour mode is used on probe once, read it on
access. This makes it impossible for the mode to be out of sync and fixes
time corruption if resetting the chip while in 12-hour mode, as
`s35390a_init` did not update the cached value.

Fixes: 16486d0c1c65 ("rtc: s35390a: handle invalid RTC time")
Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
 drivers/rtc/rtc-s35390a.c | 70 +++++++++++++++++++++++------------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
index 575bb256eb25..8e3616c65d2c 100644
--- a/drivers/rtc/rtc-s35390a.c
+++ b/drivers/rtc/rtc-s35390a.c
@@ -64,7 +64,6 @@ MODULE_DEVICE_TABLE(of, s35390a_of_match);
 
 struct s35390a {
 	struct i2c_client *client[8];
-	int twentyfourhour;
 };
 
 static int s35390a_set_reg(struct s35390a *s35390a, int reg, u8  *buf, int len)
@@ -102,9 +101,8 @@ static int s35390a_get_reg(struct s35390a *s35390a, int reg, u8 *buf, int len)
 	return 0;
 }
 
-static int s35390a_init(struct s35390a *s35390a)
+static int s35390a_init(struct s35390a *s35390a, u8 *sts)
 {
-	u8 buf;
 	int ret;
 	unsigned initcount = 0;
 
@@ -117,17 +115,17 @@ static int s35390a_init(struct s35390a *s35390a)
 	 * The 24H bit is kept over reset, so set it already here.
 	 */
 initialize:
-	buf = S35390A_FLAG_RESET | S35390A_FLAG_24H;
-	ret = s35390a_set_reg(s35390a, S35390A_CMD_STATUS1, &buf, 1);
+	*sts = S35390A_FLAG_RESET | S35390A_FLAG_24H;
+	ret = s35390a_set_reg(s35390a, S35390A_CMD_STATUS1, sts, 1);
 
 	if (ret < 0)
 		return ret;
 
-	ret = s35390a_get_reg(s35390a, S35390A_CMD_STATUS1, &buf, 1);
+	ret = s35390a_get_reg(s35390a, S35390A_CMD_STATUS1, sts, 1);
 	if (ret < 0)
 		return ret;
 
-	if (buf & (S35390A_FLAG_POC | S35390A_FLAG_BLD)) {
+	if (*sts & (S35390A_FLAG_POC | S35390A_FLAG_BLD)) {
 		/* Try up to five times to reset the chip */
 		if (initcount < 5) {
 			++initcount;
@@ -181,9 +179,9 @@ static int s35390a_disable_test_mode(struct s35390a *s35390a)
 	return s35390a_set_reg(s35390a, S35390A_CMD_STATUS2, buf, sizeof(buf));
 }
 
-static char s35390a_hr2reg(struct s35390a *s35390a, int hour)
+static char s35390a_hr2reg(int hour, bool twentyfourhour)
 {
-	if (s35390a->twentyfourhour)
+	if (twentyfourhour)
 		return bin2bcd(hour);
 
 	if (hour < 12)
@@ -192,11 +190,11 @@ static char s35390a_hr2reg(struct s35390a *s35390a, int hour)
 	return 0x40 | bin2bcd(hour - 12);
 }
 
-static int s35390a_reg2hr(struct s35390a *s35390a, char reg)
+static int s35390a_reg2hr(char reg, bool twentyfourhour)
 {
 	unsigned hour;
 
-	if (s35390a->twentyfourhour)
+	if (twentyfourhour)
 		return bcd2bin(reg & 0x3f);
 
 	hour = bcd2bin(reg & 0x3f);
@@ -210,7 +208,7 @@ static int s35390a_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct s35390a	*s35390a = i2c_get_clientdata(client);
-	int i;
+	int i, err;
 	u8 buf[7], status;
 
 	dev_dbg(&client->dev, "%s: tm is secs=%d, mins=%d, hours=%d mday=%d, "
@@ -218,14 +216,18 @@ static int s35390a_rtc_set_time(struct device *dev, struct rtc_time *tm)
 		tm->tm_min, tm->tm_hour, tm->tm_mday, tm->tm_mon, tm->tm_year,
 		tm->tm_wday);
 
-	if (s35390a_read_status(s35390a, &status) == 1)
-		s35390a_init(s35390a);
+	err = s35390a_read_status(s35390a, &status);
+	if (err == 1)
+		err = s35390a_init(s35390a, &status);
+
+	if (err < 0)
+		return err;
 
 	buf[S35390A_BYTE_YEAR] = bin2bcd(tm->tm_year - 100);
 	buf[S35390A_BYTE_MONTH] = bin2bcd(tm->tm_mon + 1);
 	buf[S35390A_BYTE_DAY] = bin2bcd(tm->tm_mday);
 	buf[S35390A_BYTE_WDAY] = bin2bcd(tm->tm_wday);
-	buf[S35390A_BYTE_HOURS] = s35390a_hr2reg(s35390a, tm->tm_hour);
+	buf[S35390A_BYTE_HOURS] = s35390a_hr2reg(tm->tm_hour, status & S35390A_FLAG_24H);
 	buf[S35390A_BYTE_MINS] = bin2bcd(tm->tm_min);
 	buf[S35390A_BYTE_SECS] = bin2bcd(tm->tm_sec);
 
@@ -256,7 +258,7 @@ static int s35390a_rtc_read_time(struct device *dev, struct rtc_time *tm)
 
 	tm->tm_sec = bcd2bin(buf[S35390A_BYTE_SECS]);
 	tm->tm_min = bcd2bin(buf[S35390A_BYTE_MINS]);
-	tm->tm_hour = s35390a_reg2hr(s35390a, buf[S35390A_BYTE_HOURS]);
+	tm->tm_hour = s35390a_reg2hr(buf[S35390A_BYTE_HOURS], status & S35390A_FLAG_24H);
 	tm->tm_wday = bcd2bin(buf[S35390A_BYTE_WDAY]);
 	tm->tm_mday = bcd2bin(buf[S35390A_BYTE_DAY]);
 	tm->tm_mon = bcd2bin(buf[S35390A_BYTE_MONTH]) - 1;
@@ -292,7 +294,7 @@ static int s35390a_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct s35390a *s35390a = i2c_get_clientdata(client);
-	u8 buf[3], sts = 0;
+	u8 buf[3], status1, status2 = 0;
 	int err, i;
 
 	dev_dbg(&client->dev, "%s: alm is secs=%d, mins=%d, hours=%d mday=%d, "\
@@ -301,22 +303,22 @@ static int s35390a_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 		alm->time.tm_mon, alm->time.tm_year, alm->time.tm_wday);
 
 	/* disable interrupt (which deasserts the irq line) */
-	err = s35390a_set_reg(s35390a, S35390A_CMD_STATUS2, &sts, sizeof(sts));
+	err = s35390a_set_reg(s35390a, S35390A_CMD_STATUS2, &status2, sizeof(status2));
 	if (err < 0)
 		return err;
 
 	/* clear pending interrupt (in STATUS1 only), if any */
-	err = s35390a_get_reg(s35390a, S35390A_CMD_STATUS1, &sts, sizeof(sts));
+	err = s35390a_get_reg(s35390a, S35390A_CMD_STATUS1, &status1, sizeof(status1));
 	if (err < 0)
 		return err;
 
 	if (alm->enabled)
-		sts = S35390A_INT2_MODE_ALARM;
+		status2 = S35390A_INT2_MODE_ALARM;
 	else
-		sts = S35390A_INT2_MODE_NOINTR;
+		status2 = S35390A_INT2_MODE_NOINTR;
 
 	/* set interrupt mode*/
-	err = s35390a_set_reg(s35390a, S35390A_CMD_STATUS2, &sts, sizeof(sts));
+	err = s35390a_set_reg(s35390a, S35390A_CMD_STATUS2, &status2, sizeof(status2));
 	if (err < 0)
 		return err;
 
@@ -325,8 +327,8 @@ static int s35390a_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 	else
 		buf[S35390A_ALRM_BYTE_WDAY] = 0;
 
-	buf[S35390A_ALRM_BYTE_HOURS] = s35390a_hr2reg(s35390a,
-			alm->time.tm_hour) | 0x80;
+	buf[S35390A_ALRM_BYTE_HOURS] = s35390a_hr2reg(alm->time.tm_hour,
+						      status1 & S35390A_FLAG_24H) | 0x80;
 	buf[S35390A_ALRM_BYTE_MINS] = bin2bcd(alm->time.tm_min) | 0x80;
 
 	if (alm->time.tm_hour >= 12)
@@ -345,14 +347,17 @@ static int s35390a_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct s35390a *s35390a = i2c_get_clientdata(client);
-	u8 buf[3], sts;
+	u8 buf[3], status1, status2;
 	int i, err;
 
-	err = s35390a_get_reg(s35390a, S35390A_CMD_STATUS2, &sts, sizeof(sts));
+	if (s35390a_read_status(s35390a, &status1) == 1)
+		return -EINVAL;
+
+	err = s35390a_get_reg(s35390a, S35390A_CMD_STATUS2, &status2, sizeof(status2));
 	if (err < 0)
 		return err;
 
-	if ((sts & S35390A_INT2_MODE_MASK) != S35390A_INT2_MODE_ALARM) {
+	if ((status2 & S35390A_INT2_MODE_MASK) != S35390A_INT2_MODE_ALARM) {
 		/*
 		 * When the alarm isn't enabled, the register to configure
 		 * the alarm time isn't accessible.
@@ -381,8 +386,8 @@ static int s35390a_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
 
 	if (buf[S35390A_ALRM_BYTE_HOURS] & 0x80)
 		alm->time.tm_hour =
-			s35390a_reg2hr(s35390a,
-				       buf[S35390A_ALRM_BYTE_HOURS] & ~0x80);
+			s35390a_reg2hr(buf[S35390A_ALRM_BYTE_HOURS] & ~0x80,
+				       status1 & S35390A_FLAG_24H);
 
 	if (buf[S35390A_ALRM_BYTE_MINS] & 0x80)
 		alm->time.tm_min = bcd2bin(buf[S35390A_ALRM_BYTE_MINS] & ~0x80);
@@ -416,7 +421,7 @@ static int s35390a_rtc_ioctl(struct device *dev, unsigned int cmd,
 		break;
 	case RTC_VL_CLR:
 		/* update flag and clear register */
-		err = s35390a_init(s35390a);
+		err = s35390a_init(s35390a, &sts);
 		if (err < 0)
 			return err;
 		break;
@@ -503,11 +508,6 @@ static int s35390a_probe(struct i2c_client *client)
 		return err_read;
 	}
 
-	if (status1 & S35390A_FLAG_24H)
-		s35390a->twentyfourhour = 1;
-	else
-		s35390a->twentyfourhour = 0;
-
 	if (status1 & S35390A_FLAG_INT2) {
 		/* disable alarm (and maybe test mode) */
 		buf = 0;

-- 
2.54.0

