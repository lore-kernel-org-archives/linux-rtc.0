Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DDF486B8C;
	Thu, 24 Sep 2026 15:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790262476; cv=none; b=q3x9qB3fqmc0iOclx5F2jUngLwDvfVND9zwtClsoP6kI/qvywif+35PP0RWmfH47uzwLHdvV8GJd79f1pqhrtEpJj6mK+uk0AJT19mnIk1Ujj7d0W76wS5fcce8JChVFXST9kyI70hu4V9BiiwfZGl95UaJqSQ8PiLNnjUqKLEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790262476; c=relaxed/simple;
	bh=iAEpuWdWh4c0sq8fS9n9pnn4X8j1O9kjjI9s19X8kCc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Ilc/rrxn7GQJqWAoDZttKpAlnmVhyR2dUJbQe8uCRtqGOq3BMSUcn+inkaETVZ7zkO/Mq5n5dD3Pe/1gmd/ijYZCT49KDF+NWKh37BPKsV1uG0a2JtB0KUBRS3TmhJcO/WELKylEhn8ulpCEqjlMw5kgpTXDJ1QkfXOGLrCqMG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ZHf3lxY/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mLA5j5eI; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ZHf3lxY/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mLA5j5eI"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.stl.internal (Postfix) with ESMTP id 3E6681D000B9;
	Thu, 24 Sep 2026 11:07:53 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Thu, 24 Sep 2026 11:07:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790262472;
	 x=1790348872; bh=DuVmmPWvLFo1tADCTa4YE4tBQUZ9cf+149PFWyAUzgM=; b=
	ZHf3lxY/yyrbko5Oet6JenwTTu+KozAP2vcXzKEsAWGN/LNQPaqwjrAbTZzkhhUp
	22cgSZSPL6OcWCk20GOGdozn/pLGU5f3o5lBqkOgyoTebqrV4zOidt2/N6JViYm9
	ZNndzUxLLP02f0t6v+fjlZskiG8d6S8m6Lv6uN1DBWn6NMMXsx6JM1FwJEL27MLw
	Dtj2kzBrSegnxm1q5fG8OiIY1wMEh923Nr7wA/Ges8RWXcbOlN2luhqlDhwTrf8U
	SeWrbldSkaNe0FzUNgslAyqDIZXr4b7H18+q6ZEh+z1wYcmK9EYtfKFqZ7dZ305j
	xD0/l8/n9D7qzWMHmXHNhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790262472; x=
	1790348872; bh=DuVmmPWvLFo1tADCTa4YE4tBQUZ9cf+149PFWyAUzgM=; b=m
	LA5j5eIBz0XRFkBc45SQTTk1EUy/mdWfbt9iUyA4NiEiOC1emflavRsHZlHg4uM1
	V4blotZ8liz3xeVIrWxqribHXn44Yt5WoGUeQdQv7/0i3R57sytARt2q8NfDuy8u
	zUNU5Ut07dnzKwIIgs6oRCmoRYDZvMxQk9DGJV5rX12bcYj2Nt7MgvcolRsPtbjZ
	0paZrhIz7btXJTywyHFkvI1WCW+bp5N9dzQlSvclewX7rPoR7exykA/LfwVKdhWM
	JkXoMtPBXvIxNB3sw47j6S3YMIzE1l1unD5mup60cYLNHauxyhEwbc2oYYkOXVni
	XNWSXBGcNdIpJ4BOpEOrQ==
X-ME-Sender: <xms:xjy1aoUyKbQ7WKzw2nTF5Hxn6G7hGh7PdAk1_l6LAop18_T36rOx5A>
    <xme:xjy1anbUGH3BB0bERDFnYBfbw4y9V--rRhHXbWnRrNUin-_dT-ojnoX4fpLh1cS84
    W5_PQ4h0Je5UW98ge9N6JsE_5saTGBSIA0AZtmtqgcxDvUfrP6-cWfB>
X-ME-Proxy-Cause: dmFkZTE2aAilufwqJab6BJLoyNd+iaKF9BZ5znOcgzqil716KvqAiK9K56dhTTjDUlMlue
    v5FOpw7mi6gH4JI7b0pyFUCUjrEXvJT/1IqrI+U+C8ErCdCI7n5aFVMy8pY9ciLkpGqaad
    LwfPdHrYOsaojOGVUiP4tSofMwK4gtmKt6uAoqiFIrqZWykBgIHFOV4QYoSbHORHN+UNaT
    5bI1evCOqjxLB51601DRWi9gx3I2+NiagkBgZv8HOChiPESkejR2EzL3NHkvy/l/GzSoTV
    CQ3LEdtryiquNAq4s2qAooaXw1qcQGLLqFhH8tfRsjugyNe+RYtJOrLJkeGwQWUpnm2JKo
    pxYg/ElOzUPOPJlnth9aWweLwiHe3Rf85+NvpDVBkzSV8Vi6o50HeknE4FRGsjrPBwyQqO
    KBFbh/22rHK0XTAkkdiYl3PjqMasHhRIfW7tKD56xZeSz/P+MHE1FcY7KxKtSub6GGbIkc
    gUfrJ9hxHJn9zZAjsPPc+uRuIiVU3uYo9oJ8mMe2f5dHUWmLdyryUXADwDt9qcbegGtbJq
    +YtKSE5ZMsltvKTne6XowF36eT3a6MefgjFOY/FLuaCyOl/74IwVstqe0rynSWryPsdHjE
    eCARTjVmX6zb+k/+5Mi2XB9cbx0FLWUgig3uOUsR3kEZEuTz7JJxe4DMriPw
X-ME-Proxy: <xmx:xzy1ategp8acRXGYwyDsXI4PndRc_m7Oli66obWuizR7gtLGDKbzNg>
    <xmx:xzy1amrzqjb61VZKHtMR4cTBPe1dTdY7wGXwaB0Xze_9f36jlG6Crw>
    <xmx:xzy1aqDzHbdFTK9uSXJBHTdnDoAwufO4eKSF4brFleo5K-PKgXd4sA>
    <xmx:xzy1arZhT1NS1GKi_QXKCF9xD9YyKvxl3BaLzG7kUaxDhO6xP8ewig>
    <xmx:yDy1akJ8LDnhw15fU6DEk8Af6DCkv5nO9xSmaGWnbnYxj8NelgZjYz7t>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 72B0932A008B; Thu, 24 Sep 2026 11:07:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ApDcdGHCsDIN
Date: Thu, 24 Sep 2026 17:07:30 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Alexandre Belloni" <alexandre.belloni@bootlin.com>
Cc: "Karl Mehltretter" <kmehltretter@gmail.com>, linux-rtc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <d7825e87-93f2-4444-bf3b-45a4127de7a9@app.fastmail.com>
In-Reply-To: <202609222137059e745547@mail.local>
References: <20260914212537.1452-1-kmehltretter@gmail.com>
 <7c020979-cf03-4ece-a7d4-b1475d1400c3@app.fastmail.com>
 <aqnHDxRIBncNH6qr@gmail.com>
 <59ba6707-c5d5-4fd8-9200-f910e61d9232@app.fastmail.com>
 <aq3R5QnCpu_fOq8g@gmail.com>
 <5515c266-f9cd-405f-b7a8-1ec45d9d902a@app.fastmail.com>
 <202609222137059e745547@mail.local>
Subject: Re: [PATCH] rtc: class: Make the time32 hctosys limit configurable
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Sep 22, 2026, at 23:37, Alexandre Belloni wrote:
> On 19/09/2026 11:16:29+0200, Arnd Bergmann wrote:
>> On Sat, Sep 19, 2026, at 02:10, Karl Mehltretter wrote:
>>
>> config RTC_HCTOSYS_TIME32_LIMIT
>> 	bool "Reject RTC dates after the 2038 cutoff"
>> 	depends on RTC_HCTOSYS && !64BIT && COMPAT_32BIT_TIME
>> 	default y
>> 
>> to completely disallow it. I think we should wait for Alexandre
>> to comment here, as it's his subsystem in the end and I'm sure
>> he has an opinion on the matter.
>> 
>
> I gave it some thought for the past month as this is an issue that is
> regularly brought up.
>
> The first thing is that this is an issue that disappears as soon as
> RTC_HCTOSYS is not used. RTC_HCTOSYS has plenty of issue and one of
> those is that is doesn't actually work well with NTP. There is a fix for
> this and it would slow down every boot by a second or two.

Sure, simply disallowing RTC_HCTOSYS on any build that contains support
for time32 userspace would also avoid this.

> The main issue is that systemd decided to mandate RTC_HCTOSYS when
> raising up the issue, the answer is that it is unacceptable to have logs
> that are not properly dated until userspace sets the system time. But
> letting userspace set the system time simply solves the issue as it will
> always set a time that it can handle, even if not correct.

Not sure what exactly you are suggesting here. Do you mean we should
try again to address this in systemd in order to no longer need
the RTC_HCTOSYS hack?

      Arnd
