Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636DD43C048;
	Wed, 30 Sep 2026 08:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790755399; cv=none; b=eUAXLoZ3ctI3j0O+B66lEmfkU0RvmFm4NQofHy0VTCdH8vx95Ck9jtveBQeFR5RzFM06xhvCIIgxp5DPLS0WhKBMpcTB4lY0Ipg4Mxl0QbgqFl0sRZ4FJFpuyinP7nOWCCVJ0KA4bqZJmsvoNqchWdFrcqS0EXgoco/Asg4W0qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790755399; c=relaxed/simple;
	bh=dh+0TD4Q8Ld4/0NaNW/Tm5NmvuVeLeaa9CG7pAVotTM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kLcpPnglMc5ma+tujMo4GSM736+c8djHxbGCvRKVES0kRJkqzPZMkpeNqlF1hvesD4+G1qfO40IpBa+BgT+jUC2NJlv0pPEyz0gdQVtapoy7z7ANit2SQJUUlVhAICdzEIezZfVJJW8lFlNkqEi0zt/coJzkJL/SmDx6fKie5hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cytV5/Fw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cytV5/Fw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C06F1F000FF;
	Wed, 30 Sep 2026 08:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790755397;
	bh=RFXD+3BTcYu1u7ckjfJBPfUkykvdr+iZkbuP/RjYMOE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cytV5/FwO+TKQMoQF2yUXUtBOvFXl3cc+86NwjGnx8omYEumweaOoCav6EMAjLCWL
	 zwg/IjqY9DfAlH7AJ55fNvpShp/RwqDNgNPmFXwZXpFtVFdPq1/EU6XE282BLez/zD
	 i5Rv/JTfxbOiAkCSPS8NAc6wsNJoJpAmIa936nU8cBvGn2KhPcMUp4P02nm4+mTDID
	 KCb8KVAor4vb+oI2SH2VvzQ3+Qs6DcpKhnvjm4n9PpZ3rG60vMKz2zzAnsJsEdo/bo
	 j+3xAQ2A3JJdJSy7hvlxatdmcrxcrbqiqec948hnXnYnrPvehVTAtyBcsrCfJTgWzn
	 GsUwYIwiz3bUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/2] rtc: Add Raspberry Pi 5 RTC driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sander Speetjens" <sander.speetjens@gmail.com>
Cc: linux-rtc@vger.kernel.org, robh@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260930074608.479089-3-sander.speetjens@gmail.com>
References: <20260930074608.479089-1-sander.speetjens@gmail.com>
 <20260930074608.479089-3-sander.speetjens@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 08:03:17 +0000
Message-Id: <20260930080317.8C06F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] rtc: raspberrypi: Inconsistent and incorrect endianness handling i=
n mailbox payloads
--

commit c554fe764e1f4efa5538d88ac395b815f0df4aa3
Author: Sander Speetjens <sander.speetjens@gmail.com>
rtc: Add Raspberry Pi 5 RTC driver

This commit upstreams the downstream Raspberry Pi 5 RTC driver. It binds a
new rtc-raspberrypi driver to the device via the raspberrypi firmware
driver and accesses the custom DA9091 RTC using the firmware mailbox.

> diff --git a/drivers/rtc/rtc-raspberrypi.c b/drivers/rtc/rtc-raspberrypi.c
> new file mode 100644
> index 0000000000000..53178d1eaf48c
> --- /dev/null
> +++ b/drivers/rtc/rtc-raspberrypi.c
[ ... ]
> +static int rpi_rtc_read_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct rpi_rtc_data *vrtc =3D dev_get_drvdata(dev);
> +	u32 data[2] =3D { RTC_TIME };
> +	int err;
> +
> +	err =3D rpi_firmware_property(vrtc->fw, RPI_FIRMWARE_GET_RTC_REG,
> +				    &data, sizeof(data));
> +	rtc_time64_to_tm(le32_to_cpu(data[1]), tm);

[Severity: High]
Does passing a u32 into an le32_to_cpu() cast here cause a Sparse warning?
Should data be strictly typed to handle endianness without triggering warni=
ngs?

> +	return err;
> +}
> +
> +static int rpi_rtc_set_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct rpi_rtc_data *vrtc =3D dev_get_drvdata(dev);
> +	u32 data[2] =3D { RTC_TIME, cpu_to_le32(rtc_tm_to_time64(tm)) };

[Severity: High]
Does assigning the __le32 return value of cpu_to_le32() to a u32 array
trigger a Sparse warning?=20

Also, is it intentional that the time value is swapped while the register
index (RTC_TIME) is sent in host endian format? This could lead to
inconsistent byte swapping on big-endian architectures.

> +
> +	return rpi_firmware_property(vrtc->fw, RPI_FIRMWARE_SET_RTC_REG,
> +				     &data, sizeof(data));
> +}
> +
> +static int rpi_rtc_alarm_irq_is_enabled(struct device *dev, unsigned cha=
r *enabled)
> +{
> +	struct rpi_rtc_data *vrtc =3D dev_get_drvdata(dev);
> +	u32 data[2] =3D { RTC_ALARM_ENABLE };
> +	s32 err =3D 0;
> +
> +	err =3D rpi_firmware_property(vrtc->fw, RPI_FIRMWARE_GET_RTC_REG,
> +				    &data, sizeof(data));
> +	*enabled =3D data[1] & 0x1;

[Severity: High]
Can applying a bitmask directly to the unswapped firmware value evaluate the
wrong byte on big-endian systems?

> +	return err;
> +}
[ ... ]
> +static int rpi_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *ala=
rm)
> +{
> +	struct rpi_rtc_data *vrtc =3D dev_get_drvdata(dev);
> +	u32 data[2] =3D { RTC_ALARM };
> +	s32 err =3D 0;
> +
> +	err =3D rpi_rtc_alarm_irq_is_enabled(dev, &alarm->enabled);
> +	if (!err)
> +		err =3D rpi_firmware_property(vrtc->fw, RPI_FIRMWARE_GET_RTC_REG,
> +					    &data, sizeof(data));
> +	rtc_time64_to_tm(data[1], &alarm->time);

[Severity: High]
Unlike in rpi_rtc_read_time(), the alarm time read from firmware here is not
byte-swapped. Could this lead to corrupted time parsing on big-endian syste=
ms?

> +
> +	return err;
> +}
> +
> +static int rpi_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alar=
m)
> +{
> +	struct rpi_rtc_data *vrtc =3D dev_get_drvdata(dev);
> +	u32 data[2] =3D { RTC_ALARM, rtc_tm_to_time64(&alarm->time) };

[Severity: High]
Neither the register index nor the alarm time payload appears to be
byte-swapped here. Does this need a cpu_to_le32() conversion similar to
rpi_rtc_set_time() to ensure correct behavior on big-endian hardware?

> +	int err;
> +
> +	err =3D rpi_firmware_property(vrtc->fw, RPI_FIRMWARE_SET_RTC_REG,
> +				    &data, sizeof(data));
[ ... ]
> +static int rpi_rtc_set_charge_voltage(struct device *dev)
> +{
> +	struct rpi_rtc_data *vrtc =3D dev_get_drvdata(dev);
> +	u32 data[2] =3D { RTC_BBAT_CHG_VOLTS, vrtc->bbat_vchg_millivolts * 1000=
U };

[Severity: High]
The voltage configuration payload is transmitted to the firmware in host-en=
dian
format without swapping. Does this cause the RTC firmware to receive an inv=
alid
charge voltage on big-endian systems?

> +	int err;
> +
> +	if (vrtc->bbat_vchg_millivolts !=3D 0 &&
> +	    (vrtc->bbat_vchg_millivolts < vrtc->bbat_vchg_min_millivolts ||
> +	    vrtc->bbat_vchg_millivolts > vrtc->bbat_vchg_max_millivolts)) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930074608.4790=
89-1-sander.speetjens@gmail.com?part=3D2
