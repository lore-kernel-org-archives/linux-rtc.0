Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793817523;
	b=inYqIrcUHLnQwUoSWHWpTRqQ0aQM2lZ8dL7g9QRsz5tHG2pOLd4b4cp4IBCq0tEgPXGd
	 hnvkvSGXECFewolY70Z88f3hT+EGVnX2Dgy0X7UzvyemWi3cyClqjA1lVf/lZwJ2FKqGN
	 NUjEV6hCQQs8vMsAsoeGj7DoGxyhLMzH28eTHOHGkClLRvqQKvICuVQ9Pv+4BosByZRZa
	 PGJM8fAfCbFkhKg+bREhj0jSaK4wO8nGzRTxO6zlFbD8FDXuwh8prpG6C9jHZ+k3pZHRy
	 OuxzRr1LLkHHl8uyC0ayrHEigP7lehEVhkYu9GfgsmvD0oUKjOjLO5lFdcDCz32gJWw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817523;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=+G4rf1hzJmKdD7EoOaWqne7TUKWl699YR7p6ZHK04Pg=;
	b=aQY4ti/YQeBHc4KC+rb9kgOilJ2ibBGQ/B7B3grDLj2vL3m2ZmwWddpVQ8bYGp1QW4xs
	 vnEXZE6HBOXHBpZxMfzOE5kf7CEQH56rJEgmuv4R4HF+jKsSmmaAyZ9feKPXWJodb4zaS
	 NAHXqFZ6ZA/MpdSLlOz+wMhvdldKhARmApIZuSO3ovf1tjW3jfzxS3BA19EdHrYLgmPXE
	 iG3ZwwhS4NWjyzxL1PV98l69QK6NDg4CGamjPh7+E3rYyWKE6oLufIXa4WZ22hTPrsDk2
	 ellTsokNZ/stJ8na/eyK6i0y9puj2z+PAw9hkhHXzwmZf572ToDymmz236a1gOhLRZw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=iav.lv;
	spf=pass smtp.mailfrom=iav.lv;
	dkim=pass header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b="XwsE/OKh";
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.15
Received: from sender-op-o15.zoho.eu (sender-op-o15.zoho.eu [136.143.169.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA22C606D813;
	Wed,  4 Nov 2026 18:38:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA22C606D813
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=XwsE/OKh
ARC-Seal: i=1; a=rsa-sha256; t=1793817483; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=jOiOl+0CE+ACVKVx2qnxTLmr810zE/CRa3KOwEr2zNkoJc25NbMCCdee3UXcgi4SvHxIB9BtXeTa0IVCXrN70PWks0O6lrv3nUDrmsbs7zmRhW0uVtNFMd0VTFsWtSr8+/uuFcaXlBFobGvMea9hXuGXpJvGRq1hcefv3O2S7cE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1793817483; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+G4rf1hzJmKdD7EoOaWqne7TUKWl699YR7p6ZHK04Pg=; 
	b=KMm2Qa0cQcm1Y27OQJWy4TNMM30UFPAzO1jo5bniPHxWFY0Eda/ucpPhYTde4l6Pg2NFIbfnvQFVZX1Ll+NpPo+lgbZt1jPYyQdzP1mocMFucUS2ZDb6+KaOPLwNzr7Ds4lccHlD684uAul0XSMWEoK4teQbqi8DSwUGyg4TaIs=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: a=rsa-sha256; b=XwsE/OKhgSV8BT27J+m5RtLTpGlmD2r5OAJQBoml3G3mJAKrH4UlhmUacSyvaKRjiVf6jv2WIYpVW3Zf1hnYQuMIP8iVKsbm/g6dLhyYNPkj9JoZW4z3McwqHJCweLV6luJLFyFNmNcj9d8s1sIjsmdVL0IaFCIvnJVaF1p0uAk=; c=relaxed/relaxed; s=zoho; d=iav.lv; v=1; bh=+G4rf1hzJmKdD7EoOaWqne7TUKWl699YR7p6ZHK04Pg=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 1793817481738396.6696032790776;
	Wed, 4 Nov 2026 19:38:01 +0100 (CET)
Date: Wed, 04 Nov 2026 20:38:00 +0200
From: Igor Velkov <iav@iav.lv>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: iav@iav.lv, John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Kevin Hilman <khilman@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Miroslav Lichvar <mlichvar@redhat.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/3] alarmtimer: Choose the wakeup RTC per sleep state from the device tree
Message-ID: <20261104-alarmtimer-rtc-neil-reply-1@iav.lv>
In-Reply-To: <399668f0-e97a-438e-b761-1ea6c18d904b@linaro.org>
References: <20261104-b4-alarmtimer-rtc-priority-v1-0-e996681b8086@iav.lv>
 <399668f0-e97a-438e-b761-1ea6c18d904b@linaro.org>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On 11/4/26, Neil Armstrong wrote:
> This sounds bulky, perhaps it would be much simpler if we just added
> all the available RTCs which has RTC_FEATURE_ALARM and can wakeup ?
>
> Just switch from 1 single to multiple RTCs in a linked list and you're
> done, no DT & bindings changes.

A list it is, and v2 drops linux,alarmtimer-priority.

Arming every RTC makes the coarsest one fire first: pcf8563 has no
alarm seconds, so its alarm comes up to 59 s early, and an RTC with
alarm_offset_max wakes earlier still. The board wakes before the timer
expires, and the next alarm may come seconds later: while it is still
resuming, which takes seconds with disks and PCIe, or right after it
is suspended again. Drivers then go through suspend and resume at
short intervals. Arming one RTC per sleep state avoids that, and which
RTC wakes from which state is board knowledge, so v2 keeps
linux,wakeup-states.

--
Igor Velkov
