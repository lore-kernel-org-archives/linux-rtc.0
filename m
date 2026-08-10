Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98340366051
	for <linux-rtc@vger.kernel.org>; Mon, 10 Aug 2026 05:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786340518; cv=none; b=kXjxtVhjJVfaNisVQPuDqSJ4Ic/Tfy48MMALMjWKnSmxACwq7b1NZD7R1FQmb5EXntsAk4P7DL25AJaxVO3DwCExNr2DGrxTilNyy7jtU9lseXdq4k4iu33uju0Ej9OBSK4wBY+AaCsgb7nj3IAMxeE08mmGZJRWg5GfUBMt7OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786340518; c=relaxed/simple;
	bh=D0o5SJTwXluNVzLqxh1DrcA6buYS0D5p+5EasedrgvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jH2S/IXvh3v8ga4IunyocJHuHEf8Ys7dqjVKiimLLZMeuRokQejXsgfvZBTNju657X40Wyp4rY66Djq1wUWbUBkH9BTLsOyZAXoKXkbZ0K5h18MzgHbeRWXblz8n1M0Aj1Qnc9fvRwpygeMekOPP3j3RA1N/v7nnvvep5SuzNhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZL7O7pi; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZL7O7pi"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5b3119957f0so915730e87.1
        for <linux-rtc@vger.kernel.org>; Sun, 09 Aug 2026 22:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786340514; x=1786945314; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9P5dyYkRO7MIgVHZdpUNXFuXh3XDJtlZIqvMU+tJYAw=;
        b=LZL7O7piLNcBxxrD0luSvFKF3hrDQDtbRiJHs05xH2olstLO7L0RQkdU26kMh7yYeH
         5WXIL/1UbkBB8BKWm++s0SDb1yBYEldY24uTXoY1P5mMw/eBYn4p1srX+hAVn+TGBxeq
         n+CtJh1pKSKfD9Zk1vOElECZ3Er/IujDBXp2O+rcc//Qb6QA+vt/oWtnKV5ir9q8XXj0
         nI3ygrd+Vvusif5J9wC4tpOn4IttlVkTAt6jIEPppIw8XlIcR/05+3oo7POkOcC6txWt
         SNk46RJGZ20lVNq86szezulcAbs5ebm7In86OMDNZINZPXWD4ek2GA3sIPnMtdKZyq9x
         gdlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786340514; x=1786945314;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9P5dyYkRO7MIgVHZdpUNXFuXh3XDJtlZIqvMU+tJYAw=;
        b=tTSIbYb+6GwQbegmupcYGLF4IaSKTV/bx8PwJ42hNbWxBBlg14BgiEsEszJJSnD1tw
         l9aj+4L7APxTCDqfKdKfvsVxNgliXwE0PF/mdYGqA6wPFYEZfIvdyxPZ3JXP2oKakdUZ
         lUnUS44MA056e0PrdsaEzHAV5IYPbyzn6FssXtWyV2qbWiqvejHPu1cxucsnP8vpZ+Y/
         QAOaB9c7uamEMg7uMLfuidNHrlpt2Pe/lQqs8q4di7rQ3bjW1+/kUx+XgWNWR/B+s+67
         jXqcMxZECnnr2IVq9EsU67J8T/1EZXvcdtwXXATNtkDOZ0ypiMXwDddUDu7bexssyXMR
         hxGA==
X-Forwarded-Encrypted: i=1; AHgh+RqtxHcYPXkpeF4NiaACqekig3DR3w1JTkqx1m6x9YJiv93PYq1eqvi/3VosehFqjXFOKGqTEBmaRdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbIe1pHZOf8GyWmpQDDimGAhLaKe+S6dqAW2uggChZt7afHJpp
	DobO934W96qIPJZSCgdgobt3vDLdTkmjB+hg/x7jyW8w3RKl8bJJUjRcqIY4WB3tI4c=
X-Gm-Gg: AR+sD12mS+li4rHSakv3yD/SvzNbD9HvYvLKrVwpC0cOI77jDtkqgLyQXgLuM0T3GTY
	HbigwEBpswr+0aqz9120pnXMriRq1r8ElWH1InWW8mKTSsi0W2ZPRSgNuiu0XhjwBsm3Kc78ahm
	Mk9VgMIodLgPO99WE8UEyA1zrQaoUSV1R/k3VKY8InaDxcY6a6WTvblnKtEDsVe6XEOPJjHXbmq
	LWLyCBbVHWWxyeNA5wJQL+EySzEDq/QUEWKr50EEA4Bp8OGeT3UQ1+CCzf4lTa5wI9aYqSVT33Q
	b9sc6EBlzcdbxG9X1iduxQ792X/s3eXjmlyf3TUTxH3xZX87xPJdx8+EJhESGj2bjhgaLiPFypz
	TtWvKXoCUFwodagKOSVc6yoKh5UcOn56jbHz3glp3Uxuh5WveN0kQMr8VLPbpHYaprQDAAlOi0w
	9Ar7vf5MquoyiEaod4TmZRHRyXxuO8sQ6IhxGG4UiJdAZzV7wHLhd36cbsW9oSQ+lh6W7mVXhIC
	ioDK+M18ppsaBqwBFXnnkWvEHqUeSFyb/irkELenm9McA==
X-Received: by 2002:a05:6512:39d1:b0:5b2:add9:d073 with SMTP id 2adb3069b0e04-5b2f4cdbf98mr5877083e87.46.1786340514174;
        Sun, 09 Aug 2026 22:41:54 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b304fd20a7sm1813835e87.11.2026.08.09.22.41.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Aug 2026 22:41:53 -0700 (PDT)
Message-ID: <e58db15b-9b31-42d9-b9f2-df792dd08804@gmail.com>
Date: Mon, 10 Aug 2026 08:41:52 +0300
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] dt-bindings: mfd: common ROHM PMIC properties
To: Linus Walleij <linusw@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Matti Vaittinen <matti.vaittinen@linux.dev>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney@redhat.com>, Bartosz Golaszewski <brgl@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, mfd@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-rtc@vger.kernel.org
References: <cover.1785838584.git.mazziesaccount@gmail.com>
 <838486b443af9188410d8b802a818dc0af20ea9d.1785838585.git.mazziesaccount@gmail.com>
 <CAD++jLky237PRXNmyURjNEOPPgFV00ox1HBeBev=qADxKM3nWQ@mail.gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <CAD++jLky237PRXNmyURjNEOPPgFV00ox1HBeBev=qADxKM3nWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07/08/2026 23:23, Linus Walleij wrote:
> Hi Matti,
> 
> thanks for your patch (and the other comments in reply to the
> old review).

Nope. Thank You for taking the time to do the review - and read my replies!

> 
> On Tue, Aug 4, 2026 at 12:20 PM Matti Vaittinen
> <matti.vaittinen@linux.dev> wrote:
> 
>> Sometimes the existing properties aren't 100% what reviewers would
>> prefer. When issues are minor or just cosmetic, changing the existing
>> properties is not feasible. Reviewers can't be expected to know which
>> properties are new, and which are existing - and this can lead to
>> unnecessary review discussion wasting time and energy from everyone.
>>
>> Adding a common file for re-used ROHM PMIC properties should make it
>> clearly visible that a property is re-used, when a new PMIC binding
>> refers to this file instead of (re-)describing all the existing
>> bindings. This will also help keeping the common properties identical
>> across the variants.
>>
>> Add new file listing commonly used ROHM PMIC properties.
> 
> I see the upside of this, the DT binding maintainers will decide
> on it. It has the upside you describe, but it has the downside that
> new components will always (ab-)use the old properties maybe
> even when there would be a good opportunity to modernize
> the syntax, and then the reviewers will not catch it.

I see your point :) I am not intending to "completely hide" these 
properties from the reviewers. Please, see below.

> But well, maybe that is not a big deal in the universe.
> 
> What about patching those old bindings:
> Documentation/devicetree/bindings/mfd/rohm,bd71815-pmic.yaml:
> rohm,clkout-open-drain:
> Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml:
> rohm,clkout-open-drain:
> Documentation/devicetree/bindings/mfd/rohm,bd72720-pmic.yaml:
> rohm,clkout-open-drain:
> ...to include this file as part of this patch, and delete the old defines from
> those three files?

I am patching them. I, however, am not planning to delete the properties 
completely (the comment above about not hiding properties from 
reviewers). For example, the bd71815 and bd71828, do not support (at 
least all) of the OTP configured pins which are also declared here. 
Thus, I don't want to allow those unsupported pin properties for them.

My plan is to keep the "additionalProperties: false", and require the 
supported properties to be explicitly listed in the 
rohm,bd71828-pmic.yaml and rohm,bd72720-pmic.yaml. And, when the types, 
descriptions, and allowed values (when common for all PMICs) are in the 
referenced file, the rohm,bdXXXX-pmic.yaml can become quite simple:

rohm,clkout-open-drain: true;

Enough to remind reviewers that there is legacy - and allow reviewers as 
well as authors to re-evaluate the properties - while also pointing out 
that this is existing stuff. (And allow validator scripts to catch use 
of unsupported common properties - at least if this works as I think it 
does).

> Then it is clear what is going on.
> 
> Maybe this happens in later patches, but anyway it should be part
> of this patch I think.

I somehow thought it'd be clearer to split the changes in own patches - 
but I am fully Ok with squashing these if it is preferred way.

>> +properties:
>> +  rohm,clkout-open-drain:
>> +    description: clk32kout mode. Set to 1 for "open-drain" or 0 for "cmos"
>> +      a.k.a "push-pull".
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    maximum: 1
> 
> Yeah I see now that this is already in use in three other bindings...
> 
> Today we would for a new component use something like
> rohm,clkout-drive-mode = "drive-push-pull";
> rohm,clkout-drive-mode = "drive-open-drain";
> reflecting pin control.
> 
> I do understand the idea to keep using the same bindings
> for all of Rohm MFDs. But when a completely new design
> arrives with many new properties etc, maybe we can think
> of something new?

In case of the "rohm,clkout-open-drain" - AFAIR it is not used from new 
drivers, but the new PMICs which are added, are supported by the same 
MFD driver. I am not too keen on changing the property values in this 
driver (because it'd require every user to update their dtses - which 
feels like a source of problems). Nor am I too excited about supporting 
old and new values in this driver as it makes the driver (in my opinion 
unnecessarily) more complex.

What comes to using something else for completely new designs - I'd say 
(a bit cautiously) that changing the properties there is fine. 
Cautiously because it is still dancing between "what users have used to 
see" Vs. "what feels like best course of action - Today" ;) Cautiously 
also because we don't probably want to support multiple vendor specific 
properties for same purpose - at least not in a long run.

Yours,
	-- Matti

Ps, planning to join ELCE/Plumbers this year? It'd be about a time to 
meet you in person :)

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
