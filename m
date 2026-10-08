Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCE43DE447;
	Thu,  8 Oct 2026 12:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791462361; cv=none; b=m/dUby6ptL10J3zAsVRT1SIHpGfvqdamnOuvh+5BgQL7Ejg9Kl0VqGMbubWIy82fepo6w430HK6ngNayXuAq8zOtSwxpGD85o8jtnFDpYprs4je4BP/LZvpc7Kr+5beKcBVjQFE+j4SM119o2tn1vaBUj1LnekmR5QZ/ZplHOdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791462361; c=relaxed/simple;
	bh=ShWtfG9u2K1dTXPJPw4n3h27fklSDuQid+CDWBFCOko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=quQdZlbEDpZM2Gt+59rrf+V5eSe2pmaYKdGPUIxnaCSxGRL7EU1/3F16r2KndkXR96t/0UzjB5r5+DRUt4eTQCHbh5kgOMjk08uT32FDnwirkIh4WVhGQnY3bYcP668el+fU49/cmrygw18EzSe5xFibvKqSmtJjdFooAfem7GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn; spf=pass smtp.mailfrom=kylinsec.com.cn; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinsec.com.cn
X-QQ-mid: esmtpgz12t1791462286t3d3cebb7
X-QQ-Originating-IP: dntKYlK6rW/Wxi0Fnkt8GxWBxdeEbJ3cwn8ue03XfWU=
Received: from [192.168.21.56] ( [111.8.45.130])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 08 Oct 2026 20:24:44 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13193396850255337370
EX-QQ-RecipientCnt: 10
Message-ID: <5C3461E42FDA1F15+836b6b0d-e24f-47e2-bf04-59d02ca35a1b@kylinsec.com.cn>
Date: Thu, 8 Oct 2026 20:24:44 +0800
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rtc: ftrtc010: fix negative offset handling and smatch
 warning
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Dan Carpenter <error27@gmail.com>,
 Hans Ulli Kroll <ulli.kroll@googlemail.com>,
 Linus Walleij <linusw@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Deng Yingchao <dengyingchao@kylinsec.com.cn>,
 Qin Yungao <qinyungao@kylinsec.com.cn>, Luo Qiu <luoqiu@kylinsec.com.cn>
References: <0C8AEB5636132B0C+20261008113732.581825-1-liudalin@kylinsec.com.cn>
 <20261008115913bfd12cb4@mail.local>
Content-Language: en-US
From: liudalin <liudalin@kylinsec.com.cn>
In-Reply-To: <20261008115913bfd12cb4@mail.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:kylinsec.com.cn:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: M3ziZXKDk+iOECg/2pUDzdLQDWA0HgClOpH5zmO/sr1ExRZq5zw+Orat
	o3Du0leuo3jrgq8zCMg8ZuK0g00jQVJ1JhDRk2MaIuuxMj8TP8Yt4sK5ZFm4FfOcNFUd9fa
	Rmtctit4atjCCma3muISqnJllepfxRO0Izmw7Kn0awXJWQwQOX2s7oEf8a8YM2grPiwvtGo
	BTyee9Ub9FEwkewYYO05sMzfT0cZVqcSHOrWeQfGYWM6XXtNAfC+vwFIwDxzgg3J8daUECk
	6yZt5Rw3Ze2jrn2OvkApEj30qVEgRpy5iUNefTjdTG1J+PR1nLeq6AyjowS1DXmfZc8xmZV
	05cXXk3GvZicH7ReFf0z72wu45QITxckBHYxz29DGPBFGsNfXig7hW9jcDuo4oZG409v1iN
	OhLK51eUsgaS3xsfH7LMvX5VVG4KgYSk3rt3k/JPn6t9qdDL05zfwZrnxg/qLYl/tnrsvOU
	ifOZpMGDGVSN+cWBoHSRXkKTOTIwIRnyEDcaqhMYhKgHYd5TYRwI7VAxcbVCdLFrIznam28
	cglMuM7YmRW5HUCksQhYNX4C8aymylcF85H3EK+G/Vzd/GjkxPXdDwtG2+iPra3AY4N0WZ0
	kuv4mEI8T5zZKlJo9g/HYLu3JNG48J61VlGC3bwkAlySAGEKt02d2YSMweiRwlKxH5HEoXg
	9v8JW5LLOz0lty8bvu+CJuQ/cko7IsDjyP2o5lQgP55a/BsDnnu6E9GrbgEv0Go8ku5X5S4
	alh0TfWAMmly5S+r2736/j3ixuyUAA2Xepx/VVkx5SPtIv4OdijhUsPgIUPfsRuV0q0dQ8v
	DQ8/xeWoHPqN7cP/YN8zvTTDxgwR6otBYQTX6gaLjqd67fltXNaGW1KZvuuOkSLr55hEOtW
	fxs8kwe0bH1HhO9yPoNeM1yASDOnKPEusO5PfGF2ItQP/qUSwbTW3iX9TS2S0mXq7lAVxzg
	X6/6dYfsMqBNYNLl2mui/ni8QSGEKfCQGzTXFoG3+zykTBMo9zB7OqWMkpSCiijOd82YpmY
	F+hoqBU9UDKFnDfXsuvziw2vkzW4FzMJhF+oQOKFChMY78FWOzie7JvmhEmnxM8lvGxarnC
	A==
X-QQ-XMRINFO: NS+P29fieYNwYjjdscdc6tBlmgA8e/Wkkg==
X-QQ-RECHKSPAM: 0


在 2026/10/8 19:59, Alexandre Belloni 写道:
> On 08/10/2026 19:37:32+0800, Liu Dalin wrote:
>> A prior attempted to fix the 32-bit arithmetic overflow by turning
>> the implicit u32-to-timeu64_t cast into an explicit one. However,
>> all calculations still happen in u32, inheriting the existing
>> negative offset sign-extension bug, and the explicit cast triggers
>> smatch "cast after binop" warning.
>>
> AI is lying to you, offset will never ever be negative.

Agreed, Thanks for review!!

with rtc_dev->range_min = (u64)days * 86400 + hour * 3600 + min * 60 + sec;
         rtc_dev->range_max = U32_MAX + rtc_dev->range_min;

offset will never ever be negative.

>
>> The FTRTC010 RECORD register stores a signed 32-bit two's complement
>> offset exposed through readl() as a u32. Casting the whole u32
>> expression result to timeu64_t performs zero extension, so negative
>> offsets become huge positive values.
>>
>> Fix it by casting offset to s32 first to correctly interpret the
>> two's complement sign, then promote all operands to timeu64_t so all
>> calculations are done in 64-bit space. days/hour/min/sec are
>> non-negative hardware counters, so promoting them directly to
>> timeu64_t is safe.
>>
>> Fixes: 1d61d2592c1f ("rtc: gemini/ftrtc010: rename driver and symbols")
>>
>> Signed-off-by: Liu Dalin <liudalin@kylinsec.com.cn>
>> ---
>>   drivers/rtc/rtc-ftrtc010.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/rtc/rtc-ftrtc010.c b/drivers/rtc/rtc-ftrtc010.c
>> index b29c96be40f4..65fe1e872239 100644
>> --- a/drivers/rtc/rtc-ftrtc010.c
>> +++ b/drivers/rtc/rtc-ftrtc010.c
>> @@ -72,7 +72,8 @@ static int ftrtc010_rtc_read_time(struct device *dev, struct rtc_time *tm)
>>   	days = readl(rtc->rtc_base + FTRTC010_RTC_DAYS);
>>   	offset = readl(rtc->rtc_base + FTRTC010_RTC_RECORD);
>>   
>> -	time = (timeu64_t)(offset + days * 86400 + hour * 3600 + min * 60 + sec);
>> +	time = (timeu64_t)(s32)offset + (timeu64_t)days * 86400 +
>> +	       (timeu64_t)hour * 3600 + (timeu64_t)min * 60 + (timeu64_t)sec;
>>   
>>   	rtc_time64_to_tm(time, tm);
>>   
>> -- 
>> 2.43.0
>>

