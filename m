Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594CF33CEA5;
	Thu,  8 Oct 2026 02:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791425729; cv=none; b=q3jG4MfDavrDZbJumUtfCvuP6zM3cr7unP+BVPINXf0S0eQApiyLySmrafEC2KT4Wk3ImdknPvcYlg9eYSKJkwnhI3gw3GYnDoj4kvvykwjEoLxWz+u1CnCQuR7n+6aJdfSWxtbGeUz6q8kqgHadmcdlaadBo+jV3KRa79kmS3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791425729; c=relaxed/simple;
	bh=CTV5JJVAo1+Ul04q9H/uw/uc3s0ZIJ7fVdvgS8XzbdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iqhbhvdmrC1zHcKTIgOLIzeJ3OO6aQt7Ge4t0gXxTLMP2OZcJ0iqZ0Q6H/s2ij1FR8HCQSczKw5ORWJHUjCouMoHWL8ssldZ3Y2CdsyqHW2gAHmJhZdbwJpzHHKWByaAcWoqg2hqfwRxwMpHRcZNyiwcGh2MgG6OIk6/SO17v1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn; spf=pass smtp.mailfrom=kylinsec.com.cn; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinsec.com.cn
X-QQ-mid: zesmtpsz8t1791425421ta6791c8b
X-QQ-Originating-IP: IXZlWfjKmnhqV177wfA04QR2kDyYKaDIy/hBHC2ii5A=
Received: from [10.20.30.18] ( [175.0.204.93])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 08 Oct 2026 10:10:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2114240786538988262
EX-QQ-RecipientCnt: 10
Message-ID: <9E75D1C8DDA4BAA5+4b72ad33-bf45-4cd1-b164-9da615b3dc31@kylinsec.com.cn>
Date: Thu, 8 Oct 2026 10:10:17 +0800
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] rtc: ftrtc010: fix integer overflow in time
 calculation
To: Dan Carpenter <error27@gmail.com>,
 Hans Ulli Kroll <ulli.kroll@googlemail.com>,
 Linus Walleij <linusw@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Deng Yingchao <dengyingchao@kylinsec.com.cn>,
 Qin Yungao <qinyungao@kylinsec.com.cn>, Luo Qiu <luoqiu@kylinsec.com.cn>
References: <42C8FBD59AA34EA9+20260827080320.3351155-4-liudalin@kylinsec.com.cn>
From: Liu Dalin <liudalin@kylinsec.com.cn>
In-Reply-To: <42C8FBD59AA34EA9+20260827080320.3351155-4-liudalin@kylinsec.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:kylinsec.com.cn:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MbZKagI4fS0NwOlZH/Kf+TTIsXuXXPD0dwIhp3k3+S4iuQBAVONZeuut
	o6+dBkC1BQeElBOxNyXyU5eLukJlky6e/8Ohmh+KknV/AK2GDc5+rDGQM4exWzZ55DVe3fj
	YVTNSkzu3AemDHqBLohL0AO5A0gvNqBUN9PB1ixOwJ9otp6eiEa0U7lQQ98QFNWGUYkcEyU
	PrZ3iwPCNDxVwY0rjTIDM9d7JGOyXnmCKlYFqs28mG0CL+cxjMNg3bqmKf/9vWRNvgRCAQh
	zczFClBg6dE4UZKEY+me45OjqPXqj5f7pwaehA5u0HmcyyCitoLsVdfRbWBe9k3DTkZ6P5+
	xhGFM5UlnL2htpwHQhJvzmyoofIf8/XjmBWy8bxU6fb64F6/Rrjbd/eUU45QJls0YjjSb+5
	4BVnoKJ75DfHGsFsjzO3bWIneWIPdTFcXluaERVguaOoy5myCyVYKEeoZ6j9Gf/c3YBhj/C
	6wkMrQXX14tySvDMch7qNRQydxVNAJfooQtEoYOV5HiNXQHPBVY2StlyhRiuFRfiYaVxTbl
	YbFyb7ERlJSwOcWhXIrkF7p/qwRB3KAOfNUDswXs6csH/JBnrNuIrcPDFphUnT7dEApxvu6
	jH9F4jvQk68C1GZShRCFljEAe40pT53E+CuNsyaBIgU1ak5YZdarnxSU3ETnvquet8jVfMm
	1UibuDJmFDhRWrzN1PpdgHleBi7sYnDbdLcoHgOkSrMp7XXcLKSJ/nHR6in3cuumv6a0Ztk
	YPo9uyByErc7FwNSfV+TAzQRdqxBo0UVp9xOt2sICWF/OrStWk2DlmSgoaxAeVJ2Q2VjRN2
	0363sMsTNhh1mwXgFQy7XbFQUOUiDdyuHN+M1HFvTmdIIhUH8jChNqRDdNf9VbDh+77idVk
	WlSrQPunBH6ZmJ22l0b5K2UXvElHs40Ar2M4fadTKtdCs05iU3uU4b5h74rM6hWE/OhtWHa
	WUm987ltnZ7XsYthngjEUT8IwogJxH8AZeHHfCKL/dx5p0bxrmZD/drjE78ZGamVuhdOk8a
	8lMsoVQKx2Ay/b2Ui35+Vetp4dUAMeuUo6EPUuRKnSuxIFHIAC3wo2yMknKrka0Ta2ghUaY
	Oo5s5ACxFgLncpZsI4yXDhguSDrtTzNBA==
X-QQ-XMRINFO: Nq+8W0+stu50EVyYsz6qPxhg8vxGPZA2FA==
X-QQ-RECHKSPAM: 0


在 2026/10/2 18:59, Dan Carpenter 写道:
> Commit 8ef8e9839a23 ("rtc: ftrtc010: fix integer overflow in time
> calculation") from Aug 27, 2026 (linux-next), leads to the following
> Smatch static checker warning:
>
> 	drivers/rtc/rtc-ftrtc010.c:75 ftrtc010_rtc_read_time()
> 	warn: cast after binop
>
> On Thu, 27 Aug 2026 16:03:20 +0800 Liu Dalin <liudalin@kylinsec.com.cn> wrote:
>> In ftrtc010_rtc_read_time() and ftrtc010_rtc_set_time(), all
>> variables (offset, days, hour, min, sec) are u32. The expression
>> "days * 86400 + hour * 3600 + min * 60 + sec" is evaluated in
>> 32-bit arithmetic, which silently wraps around for dates beyond
>> approximately year 2106 (U32_MAX / 86400 ≈ 49710 days).
>>
>> In ftrtc010_rtc_read_time(), perform the addition in 32-bit
>> arithmetic first to preserve two's complement wrapping for negative
>> offsets, then cast the result to timeu64_t. In
>> ftrtc010_rtc_set_time(), cast individual u32 operands to timeu64_t
>> before multiplication to prevent overflow in the right-hand side
>> of the offset calculation.
>>
>> Fixes: 1d61d2592c1f ("rtc: ftrtc010: Rename to Faraday FTRTC010")
>> Assisted-by: Sashiko AI [static analysis]
>> Signed-off-by: Liu Dalin <liudalin@kylinsec.com.cn>
>> ---
>>   drivers/rtc/rtc-ftrtc010.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/rtc/rtc-ftrtc010.c b/drivers/rtc/rtc-ftrtc010.c
>> index 19e6333bfbab..b29c96be40f4 100644
>> --- a/drivers/rtc/rtc-ftrtc010.c
>> +++ b/drivers/rtc/rtc-ftrtc010.c
>> @@ -72,7 +72,7 @@ static int ftrtc010_rtc_read_time(struct device *dev, struct rtc_time *tm)
>>   	days = readl(rtc->rtc_base + FTRTC010_RTC_DAYS);
>>   	offset = readl(rtc->rtc_base + FTRTC010_RTC_RECORD);
>>   
>> -	time = offset + days * 86400 + hour * 3600 + min * 60 + sec;
>> +	time = (timeu64_t)(offset + days * 86400 + hour * 3600 + min * 60 + sec);
> There isn't any point in doing the cast outside the parentheses.  The
> other chunk probably does it correctly.
>
> regards,
> dan carpenter
Thanks Dan for review and catching this issue.

Commit 8ef8e9839a23 is now in Alexandre Belloni's rtc subsystem tree
(https://git.kernel.org/abelloni/c/8ef8e9839a23), not yet in linux‑next 
or mainline.

You are right, the original commit 8ef8e9839a23 only tried to preserve u32
wrap‑around for the RECORD offset but had two problems:
1. It triggers smatch "cast after binop" warning.
2. More importantly, casting the wrapped u32 value to timeu64_t does zero
extension instead of sign extension, so negative offsets become large
positive values and break time calculation.

I will send a separate fixup patch addressing both issues: cast raw RECORD
u32 value to s32 for proper two's complement interpretation, then perform
all calculations in timeu64_t to avoid 32‑bit overflow.

Regards,
Liu Dalin
>>   
>>   	rtc_time64_to_tm(time, tm);
>>   
>> @@ -92,7 +92,8 @@ static int ftrtc010_rtc_set_time(struct device *dev, struct rtc_time *tm)
>>   	hour = readl(rtc->rtc_base + FTRTC010_RTC_HOUR);
>>   	day = readl(rtc->rtc_base + FTRTC010_RTC_DAYS);
>>   
>> -	offset = time - (day * 86400 + hour * 3600 + min * 60 + sec);
>> +	offset = time - ((timeu64_t)day * 86400 + (timeu64_t)hour * 3600 +
>> +			 (timeu64_t)min * 60 + (timeu64_t)sec);
>>   
>>   	writel(offset, rtc->rtc_base + FTRTC010_RTC_RECORD);
>>   	writel(0x01, rtc->rtc_base + FTRTC010_RTC_CR);
>> -- 
>> 2.43.0
>>
>>
