Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D63533F5AE
	for <linux-rtc@vger.kernel.org>; Thu, 17 Sep 2026 04:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789620458; cv=none; b=NV8NS0UEo4QyYgm3GSDa8AVxNZBnswo/Oauarv9zAzyd42YkedujuBDIgxJCpf9X05YQ3SDsmNPfvCSMMMvRYAkjJchxkgIsaNj/9rJMZk92nhYJ1jZzvlGGBe0XsKvqKdl6F/9GBlAmLhOzqyYZngkHsJWP2EWj25b4xzhWZFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789620458; c=relaxed/simple;
	bh=Lrt6YFfTcQjqGuU5FoLFJmGH0jhGaULcXBP69mPmyDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yjs4jxwAU0gcOZNR0zcW07tCuEA7owPnIsQatWzn7whifqleHgtD3pVNJrNiKD5hvFblQ6rqFjsHFpatU27YWlp0xdQR2yThdIroN9zBQ0H8mHfl76hmQo6b5WZ0jPMRUcQwlSH7pxZGaxUC8WUtAu4W+KS5QU7XSElNZATX+mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPdMPb2N; arc=none smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPdMPb2N"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a30521ef15so3101791fa.0
        for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 21:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789620453; x=1790225253; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dDYu3bsth7oi/7LPOhDffulZAY7dt7QNkv+9w7yWBC0=;
        b=WPdMPb2NDyFx/VSYB/zGk1kF7EV/kHr3gS31Q75FBV2ml2PiJZ7G5HKWX2Mb1O+d0Q
         +UOOxCDJ5mG1+0+PHRnOgZK2SuhZwZaaz+HpZFBzwuMrqcroJoW07iSpp41S5v8f1wGu
         89FEguVN6c8XaNZpc9YOCwTF9sr0mhQvsXoU2R4soG8YCU2oOpcX9dRLCHLJzMt235lQ
         QjKV/0Eem2pDaRNS1jMvxq4LG8HBoII7LDLNDsYidKD0B+9FigcsA2YXOAQMkaph7LaD
         fd75Wv5vKLrFeAslhgfFMbch8txttcKS6OpsJnEX7AiLM0HLrgJNLqWtzss1jPwEfT8+
         I25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789620453; x=1790225253;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dDYu3bsth7oi/7LPOhDffulZAY7dt7QNkv+9w7yWBC0=;
        b=PYPplEy5nioL5CVtH8hUkxU4UB41zOS0yqkveols9WkY0V3VW4YhTGSqGMv8uB2pTs
         niuC5GEzu5zzT6jNqjHPc5G1lYpSOzWH/EqemZxjIpBb9e3/z9TDXdHF+dliLNEJHT3P
         Qnd4au9p1Gxuhh4gYm33UNAxbgvUJUz6c8oouaYA3Avrlr9BYwMNSG6zol9CquxWTpUQ
         qITCtqSYj418bT9f/X8Y92/FQenmu5QP5dqZXwl1w3Z0FS6bIVpXoXCGQHo4DBfmHFXm
         ROCu8ZkOjT8s6wuRuGFTnEO++xpuuwym+ijYpABFGbxcYHZnih9eKPPZFSqow/K6T5oM
         b9rw==
X-Forwarded-Encrypted: i=1; AKwUvByDBAEIImC6HG26Dl2E20KK8pLiPH1em117MPIFOV8EEAFJ2jsYHaqNMqoXqEY+n1mO6OEm+/g7Fhg=@vger.kernel.org
X-Gm-Message-State: AFuF++lkqhatDxBgN/AY9Zv+RNdiN6MsIPCkc2ebE1gju+9ULq259ywp
	BvN8KeQF9XfH4yAB0QTuOLprKxygWmdyV7WxHYdCjyOHRE4rE8t5IDjX
X-Gm-Gg: AYBFou29q0cuhSOk68sfspsepSy2Y8dhcCk9s8sji9YvEsiaj3P8rPhsTR2Y24yNAmo
	JzEZYp1rgwdlDX2wmkAxgRx/UhUe2eChglq5IS5nfIzWW36aa7oj7F68auFGYt1GBwjoRFjYpuP
	7zxcGwthfzk61hjt025uWUgF9JEKPf+ggxz0/rYcWnwf+BryKLkYptvcdcHK3v1Vy4dScJZdAJz
	aAVNIXjHW4a6tIDKE526n4CyhbYnFpFptY64KVqaBhd40VmvxnaQVNBlIefvyvxyeNCp9W/7j0x
	UYcLhCWoKMAHWWynJk2J7QGmPdZCi9ArC2HWhAa/7jCk5yVbtfjO6sN1rhKqYEp98gQflp/Zw8o
	O6fXkYamu4xH0BSk3xWb397Bc9ACYzDSxBWARZB5iUHfp6NBKsb5AulDhPI+oMX8e5vtasXbpms
	NQXJd7ANbMLpBKCK+pjFUZRLvJcDxQkaJHxIvomcd5EeG8WJ499zk15zeba2wGKkatepB4gkYv/
	1OguVhtJVgtDEHkfBxtpeScjXPCL84r+T29h8TssGWXnB2mVg+JGIQ=
X-Received: by 2002:a05:651c:2107:b0:3a5:a106:ee0 with SMTP id 38308e7fff4ca-3a5dca17909mr10468881fa.24.1789620453050;
        Wed, 16 Sep 2026 21:47:33 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a5dafdc6fcsm11590281fa.33.2026.09.16.21.47.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 21:47:32 -0700 (PDT)
Message-ID: <f50e6a88-3436-424a-8df7-8d5e01ee531d@gmail.com>
Date: Thu, 17 Sep 2026 07:47:29 +0300
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/10] gpio: bd73800: Support ROHM BD73800 PMIC GPIOs
To: Linus Walleij <linusw@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Matti Vaittinen <matti.vaittinen@linux.dev>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>,
 Bartosz Golaszewski <brgl@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Michael Walle <mwalle@kernel.org>, mfd@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-rtc@vger.kernel.org, Sverdlin@mva-rohm.smtp.subspace.kernel.org,
 Alexander <alexander.sverdlin@siemens.com>
References: <cover.1789538455.git.mazziesaccount@gmail.com>
 <e3e6ac712519326cc25fcdd0a0c8e3cc42ef55ab.1789538455.git.mazziesaccount@gmail.com>
 <CAD++jL=vZr+naVBaixNkDbgx4_EpL8MosSyXYb9jg2hgKu+QNg@mail.gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <CAD++jL=vZr+naVBaixNkDbgx4_EpL8MosSyXYb9jg2hgKu+QNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16/09/2026 20:31, Linus Walleij wrote:
> On Wed, Sep 16, 2026 at 8:12 AM Matti Vaittinen
> <matti.vaittinen@linux.dev> wrote:
> 
>> From: Matti Vaittinen <mazziesaccount@gmail.com>
>>
>> The ROHM BD73800 PMIC has 4 pins (named GPIO1, CLKOUT, FAULT_B and
>> EXTEN_OUT) which might have been set to operate as a GPI or GPO when OTP
>> (One Time Programmable memory) is written at device manufacturing.
>> Support the GPI/GPO use-case via GPIO framework.
>>
>> The default OTP for these pins is to not use any of them as GPI or GPO.
>> (The GPIO1 defaults as an ADC input regardless the naming). Hence the
>> driver assumes none of these pins is a GPI/GPO unless explicitly pointed
>> as GPI or GPO via device tree.
>>
>> Furthermore, pin's direction can't be changed after OTP configuration is
>> done. Also the default drive type for a GPO (CMOS / Open Drain) is set
>> by the OTP configuration. The BD73800 has a set of undocumented test
>> registers which should allow changing the drive type. Access to the test
>> register area or the test registers aren't documented and so this driver
>> does not support configuring the drive type even though it might be
>> doable.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> 
> Looks really nice now!
> Reviewed-by: Linus Walleij <linusw@kernel.org>

Sorry Linus! I dropped your tag from v3 by mistake. I hope you didn't 
waste too much time re-reviewing this :( Well, thanks anyways and again!

Yours,
	-- Matti.

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
