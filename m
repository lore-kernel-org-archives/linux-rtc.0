Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4503C277B
	for <linux-rtc@vger.kernel.org>; Thu, 27 Aug 2026 08:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787818082; cv=none; b=A/4KJVilin6qjO7h6pjFZdM6tSufNF5Qf6SdlnviGWBJgEHNj3DaINT6e59rdpuuZZ4l9cm9UjAyU/GIzBO4Kf4q07RVZZbByEN3RLqKxJbV/ruuaADKHJHtQpkAsUTHo/o8dnkWuajNWAc8L0EruwaKiSV+VpScblBnSSxBdpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787818082; c=relaxed/simple;
	bh=OmI6SkkcPYSYjkgVU0gPuuOLO58LVFJH4UPNHkXXev4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L5IJqAR4EThAzQ9i7rWspBNq+iwLcgmTf6fKvJYQDKR7OCJ7DiJm1uwfpc8uithC2VsqfEPYgGu2CcZTpF5fc7+R+4ah7PqYtOxGcmN7XByjDyn1iCKFcNhrTz+xLOck4rH0prS84jnlu8vEMiSleF9mlgqAFG+NPARBiUTzGSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn; spf=pass smtp.mailfrom=kylinsec.com.cn; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinsec.com.cn
X-QQ-mid: zesmtpgz7t1787818048t73969d49
X-QQ-Originating-IP: 26/NJi8eHhdKqI2rx/1uAQmiNBDl3cY1AZulyYou38w=
Received: from [192.168.64.241] ( [111.8.45.130])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 27 Aug 2026 16:07:26 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14659579519580919907
Message-ID: <1DEB0773A8C9D6DD+0de3c2e3-2201-4670-a899-5bcc89b35cb5@kylinsec.com.cn>
Date: Thu, 27 Aug 2026 16:07:23 +0800
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] rtc: ftrtc010: fix integer overflow in time
 calculation
To: sashiko-reviews@lists.linux.dev
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-rtc@vger.kernel.org
References: <20260827021054.0963C1F000E9@smtp.kernel.org>
 <20260827063019.3342085-1-liudalin@kylinsec.com.cn>
 <B06A3E7BF268E081+20260827063019.3342085-4-liudalin@kylinsec.com.cn>
 <20260827065312.CECC11F000E9@smtp.kernel.org>
Content-Language: en-US
From: liudalin <liudalin@kylinsec.com.cn>
In-Reply-To: <20260827065312.CECC11F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:kylinsec.com.cn:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MmpliBmRb3iCf/gg9VH2OFmiM+0zxG3gub41txy8rh+FeBWUceTds6+2
	RyqDvws+tkYNpOi2kVBOzUjNFTr1vnbNN6DWPZO6OHAIs5AmYinmY5v6x7H2uQApdxJpDHS
	D1D7YhL833LMPfPyLiKO2vXIdZDDib3njLMa9KDQnhKVksY4O6DjCLPCbuQclZG3n3huQY0
	w5cuOhiij8VuuALFjTa+iuz7anPfNDcL5M9u46i9jMxExGqh3lnkXmKQ546uKizrzt2bf8b
	ySxYgs2fJplu06b8vEa17YEfK4nE6+zQzY8uKJtdVpEYR77/V0plaodD+UyTuf0HAD5yF3i
	A/fjHp2dg1IYBBhHDVlWXzWDOnkXrDlUWXNmMzXv5IzR5vI3IAEXymyapIXMkop6j54GwTH
	92qQezLVjywKkObL2Qy6+WpBusSzWN7FfRnnkgXzPeHBKFWCY1qVnZ6pTP0TELXa/eWFFHN
	WggXrdrGVt3c+Hc1Q0gsbaKkK47mGif8RRT0LomCBdtXRaYS3CIc6CjguwbJM2P8NnXrK20
	nE3fPCYqb4iuo6cZbnve99VUK/q0zvQ3zMh4dITzTgPBCsIxuq5wHbHEvwliP98eyCY3Qw1
	29b6r80biVjuK8BKH03jC+qzF7EvjxPv4TMIoZh2DFQwzkLrM/tLmvWEqfAnJeBApuYyB0v
	Ac9H/Kyz1c20w0P9IeglTacUkvJ8gbesaKg6twP7CkEU449DsKEbFe8mGevKUQ3jJtbgXZO
	uBDI8fAi3b92nW4i1q4t3nA9emipHSlrDeM5R+zSchNrWyfkV7Hpg5YMZXacppi18/Vgcpz
	XhnQc3jf4hRksWx2O57FGdxheC4dSH8U1am2S/qW+t2+TLYPstmWh6S+KvjtIAgQwRQkGJg
	buwMXLT2oozccW8QG+uRTHMSbEpM0BhtN/kbCSdOMPP0TNX2lTJWT1T3PV38X0yl0qsiSZt
	8s7i9XKBgJh+wSuxj/sLnZkODR5dAer7YHAbSgKgAs8DsBU7dEBDaOKij1NRkXKC3pygpvQ
	7pj2QtOtw5PvLXA+e3LomlpPb8Qek=
X-QQ-XMRINFO: Mp0Kj//9VHAxGvRtF542+ONDzknxnUqv0w==
X-QQ-RECHKSPAM: 0

On Thu, 27 Aug 2026, Sashiko AI wrote:

 > [Severity: High]
 > Does this transition to 64-bit arithmetic zero-extend negative time
 > offsets? If the offset is negative, casting it directly to timeu64_t
 > breaks the two's complement modulo arithmetic required to correctly
 > decode negative time differences, which could cause the clock to
 > erroneously jump about 136 years into the future.

Thank you for the thorough analysis. This is a valid issue and has been
fixed in v2.

The original code cast each operand individually to timeu64_t:
   time = (timeu64_t)offset + (timeu64_t)days * 86400 + ...

When offset is a negative time difference stored as u32 (e.g.,
0xFFFFFFFE for -2), zero-extension produces 0x00000000FFFFFFFE,
causing a ~136-year forward jump.

The fix is to perform the addition in 32-bit arithmetic first,
then cast the result to 64-bit:
   time = (timeu64_t)(offset + days * 86400 + hour * 3600 + min * 60 + sec);

The u32 addition naturally wraps using two's complement, and the
final cast to timeu64_t preserves the correct value.

For ftrtc010_rtc_set_time(), no change is needed -- the offset is
assigned to a u32 variable, which automatically truncates to 32 bits,
preserving the correct two's complement result.

 > [Severity: High]
 > This isn't a bug introduced by this patch, but can these unsynchronized,
 > non-atomic reads of consecutive RTC time registers produce corrupted
 > timestamps?

Please see the response to the same concern on patches 1 and 2. The
1 Hz tick rate makes this negligible in practice, and the hardware
provides no latching mechanism. This is outside the scope of this
patch.

 > [Severity: High]
 > This isn't a bug introduced by this patch, but can this sequential read
 > result in computing an improperly desynchronized offset?

Same as above -- outside the scope of this patch.

 > [Severity: High]
 > Does this calculation incorrectly wrap offset into a large 32-bit
 > integer? If the target Unix time is numerically smaller than the
 > hardware's internal uptime counters, the difference becomes negative.

The offset variable is u32, which stores the negative difference as
a two's complement value. When read back in ftrtc010_rtc_read_time(),
the u32 addition wraps correctly. This is the intended behavior of
the driver's offset-based timekeeping design.

--
2.43.0

在 2026/8/27 14:53, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>
> New issues:
> - [High] Transition to 64-bit arithmetic zero-extends negative time offsets, causing the clock to erroneously jump ~136 years into the future.
>
> Pre-existing issues:
> - [High] Unsynchronized, non-atomic reads of consecutive RTC time registers can produce severely corrupted timestamps if a hardware tick and rollover occurs during the read sequence.
> --
>
> commit 0451b19111beae8b1f5abde3e58d176d4ad642f2
> Author: Liu Dalin <liudalin@kylinsec.com.cn>
>
> rtc: ftrtc010: fix integer overflow in time calculation
>
> This commit addresses an integer overflow in ftrtc010_rtc_read_time and
> ftrtc010_rtc_set_time. It casts the 32-bit time variables to timeu64_t before
> multiplication to ensure 64-bit arithmetic, preventing overflow for dates
> beyond year 2106.
>
>> diff --git a/drivers/rtc/rtc-ftrtc010.c b/drivers/rtc/rtc-ftrtc010.c
>> index 2f610a0fc6e9b..6fff537cad27e 100644
>> --- a/drivers/rtc/rtc-ftrtc010.c
>> +++ b/drivers/rtc/rtc-ftrtc010.c
>> @@ -73,7 +73,8 @@ static int ftrtc010_rtc_read_time(struct device *dev, struct rtc_time *tm)
>>   	days = readl(rtc->rtc_base + FTRTC010_RTC_DAYS);
>>   	offset = readl(rtc->rtc_base + FTRTC010_RTC_RECORD);
> [Severity: High]
> This isn't a bug introduced by this patch, but can these unsynchronized,
> non-atomic reads of consecutive RTC time registers produce corrupted
> timestamps?
>
> If a hardware tick and rollover occurs during the read sequence:
>
> ftrtc010_rtc_read_time()
>      sec  = readl(rtc->rtc_base + FTRTC010_RTC_SECOND);
>      min  = readl(rtc->rtc_base + FTRTC010_RTC_MINUTE);
>      ...
>
> It appears possible to read desynchronized values, which could result in
> permanent time corruption up to 1 day.
>
>> -	time = offset + days * 86400 + hour * 3600 + min * 60 + sec;
>> +	time = (timeu64_t)offset + (timeu64_t)days * 86400 +
>> +	       (timeu64_t)hour * 3600 + (timeu64_t)min * 60 + sec;
> [Severity: High]
> Does this transition to 64-bit arithmetic zero-extend negative time offsets?
>
> If the offset is negative, casting it directly to timeu64_t breaks the two's
> complement modulo arithmetic required to correctly decode negative time
> differences, which could cause the clock to erroneously jump about 136 years
> into the future.
>
>> @@ -93,7 +94,8 @@ static int ftrtc010_rtc_set_time(struct device *dev, struct rtc_time *tm)
>>   	hour = readl(rtc->rtc_base + FTRTC010_RTC_HOUR);
>>   	day = readl(rtc->rtc_base + FTRTC010_RTC_DAYS);
> [Severity: High]
> This isn't a bug introduced by this patch, but can this sequential read
> result in computing an improperly desynchronized offset?
>
> If a tick occurs between reads:
>
> ftrtc010_rtc_set_time()
>      sec = readl(rtc->rtc_base + FTRTC010_RTC_SECOND);
>      min = readl(rtc->rtc_base + FTRTC010_RTC_MINUTE);
>      ...
>
> It seems this could permanently corrupt the stored RTC offset and skew the
> time until it is reset.
>
>> -	offset = time - (day * 86400 + hour * 3600 + min * 60 + sec);
>> +	offset = time - ((timeu64_t)day * 86400 + (timeu64_t)hour * 3600 +
>> +			 (timeu64_t)min * 60 + sec);
> [Severity: High]
> Does this calculation incorrectly wrap offset into a large 32-bit integer?
>
> If the target Unix time is numerically smaller than the hardware's internal
> uptime counters, the difference becomes negative. This can happen on offline
> embedded devices where the initial OS time defaults to 1970-01-01.
>
> Casting this negative 32-bit offset to timeu64_t zero-extends it instead of
> allowing the required 32-bit modulo arithmetic. This could lead to a massive
> forward jump when ftrtc010_rtc_read_time is subsequently called.
>
