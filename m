Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8534476688
	for <linux-rtc@vger.kernel.org>; Thu, 23 Jul 2026 17:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784827623; cv=none; b=HiUk9zDMHMf8M4Mb14Cwc6XyWszXKO5CVNIa/P3QZPZU4Y0ChMvLMaaTnuAWuxqcjBSfjMDV23ggGeUbZOghipvIF7BnKt4q5bPWCwB2Yvruu7vA3WZM7pKUrSj6QgHp8AQz16Tsuf2o7yed0HTgv4wD9nkTaWBtRHdOpPPPUmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784827623; c=relaxed/simple;
	bh=+VA14SVQz356LlYHLAhZ+li2aadA95OOjpAO85Zzm94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzmOHtTTogSkqMXgbHAJ+E5+TFDeJQhInhgYNqwmHP5ubY3LbjFqC6s76ZQHG79aFea5nyR+qjFh/HXEyDhw1EAvtkVsH5JS/mTVkFbqz7fIRPl0sLql/mkYr7OrRzW07t8vbiDsxn/BKn7LJJjzAKTugp2n4tDBprlo62LnNEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SEzTkdjs; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEzTkdjs"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47f6609c657so466918f8f.2
        for <linux-rtc@vger.kernel.org>; Thu, 23 Jul 2026 10:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784827620; x=1785432420; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=elNnZUfys+k4IsZdAhGREqHqvHAojuXZZ8zR+tYCV30=;
        b=SEzTkdjsH04WXcO/eXFXY3fVWiDamrNZlSe+KUHqhlvVkmjIPqXkeeHwz7Ha4j3hQa
         dPS4QC2FW7DX+LvR76sIc4WoX0Nq1VhN1mcZFxxmp1DjmTgIChcJ8sFdEzlGZ9xW2EoT
         XgXa0FO3i4xMLOkGi1Cn5Nm/2ZTg68bbFYleM6IaUzv3Ns7925hRl476EqvA5LgXzXTz
         M+E8iglCRHfQyFlVpUhZa76eu2+52G505gPMM/c3wUYdQiwPXbdOGLf6vJ6W//Zqw+hQ
         8itwlffwPsRq29/XoJ8aYTKFHsR0AZuQVCMyeViI9F9fxgwgPUmHVUkMECsaV+lvbJKZ
         /OaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784827620; x=1785432420;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=elNnZUfys+k4IsZdAhGREqHqvHAojuXZZ8zR+tYCV30=;
        b=dIJpHfS5RqqVIRBTL7vuujgNuTIoUZrhmV77SSDiA1JrzwwcQgXvca8IHlOQ4reIJd
         g2V5getb3AOl/5gayZE54a9u0/Em4eeDjZjQ8S0KQdh5gbhm/bMGXo/8vmVXMb9ZdS/G
         KltAPQgg1L6FLzgzOgx7dnXtjju5vjBnJ9S9tMGr0Kb5g/0reO1ut9azx7EKLXObbGem
         0n6SLhrF17uAKi5NPvjHZ3//WUmdJCPnb4zG2Ypfb2Xy307Y1ITX8sr7PDA0kdVcNJTs
         xGRAD9weyrNcvZ0HSKI1zO+t+C17Mq5LTUcFKBqLTh+kZpczYLfcvS6A3levebDrKb9l
         LycA==
X-Forwarded-Encrypted: i=1; AHgh+RqrYZyFB/vGFAsQ5XuDAmBltDZ9ve1NlLSc1nP9+Q2Bh0+Y/7Tbw7C7zdSP6V0YaibD9xwc77JduWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzohuR4GemGStZ1L+Xg1MmFVzYswPM95ovqNy1h0inFuBufa/6o
	WYFxJYPFOug7QfM+s7Kl4hOecMaLe65OJK87QsAFBSnepk/ZrArQrLZ/
X-Gm-Gg: AR+sD12GmcrKwotebs2zYkCxq8NC42mAGUArRkjGg3Y6j7cQ1nOKTSuWsJ1/2VEV1CE
	asymVub+gQDDP9tH3AaJAJMakFD/tyJSVTxgqXR1CblHulsCKybPOF90UHDZV/DY2Okmb+sEY9l
	gmecRAnHAyYz7vcB/xVcbQJmCy25/Q1ZbXM9dkR5jQCZVNFE0kogbd9ZhVk/9lwS7FPB5aM72Kk
	dqLLDs4Le+M3bMGe8jlzCxIsYJw8BeW0BMtqSTeBj30xuP0hzEIc2s68MEd9dYR1Z5oY0q9BdfV
	Uv3jQ4aLGst8NTW90Nk573fsfFCIBrGvpL40WlbiTZWsAiKyER7r1rHZMZ975KUvXmbirDcwKn3
	/bqmuOtNV7IGaALWDFVwa/81IS/+P4+5ErhR/jT+tIYKgvyNnhQqhNO/rR8KUT8Q0RuJeojAsFL
	73Lmpx0I6MakK7mcY=
X-Received: by 2002:a05:600c:524e:b0:492:7142:f46e with SMTP id 5b1f17b1804b1-49573c8d44fmr47076895e9.2.1784827619498;
        Thu, 23 Jul 2026 10:26:59 -0700 (PDT)
Received: from antoniarch ([78.212.250.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957af6a14csm7615325e9.5.2026.07.23.10.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 10:26:59 -0700 (PDT)
Date: Thu, 23 Jul 2026 19:25:13 +0200
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: alexandre.belloni@bootlin.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: rtc: abx80x: document ABX81X RTCs
Message-ID: <amJNgGCVCmHtAx_N@antoniarch>
References: <20260722195814.298552-1-apokusinski01@gmail.com>
 <20260722195814.298552-2-apokusinski01@gmail.com>
 <20260723-briar-hut-82e980e9996a@spud>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723-briar-hut-82e980e9996a@spud>

On Thu, Jul 23, 2026 at 05:44:03PM +0100, Conor Dooley wrote:
> On Wed, Jul 22, 2026 at 09:58:09PM +0200, Antoni Pokusinski wrote:
> > Abracon AB0815 and AB1815 are RTC modules with SPI interface.
> > 
> > Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
> > ---
> >  .../devicetree/bindings/rtc/abracon,abx80x.yaml   | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/rtc/abracon,abx80x.yaml b/Documentation/devicetree/bindings/rtc/abracon,abx80x.yaml
> > index 355b0598411a..234a103724b5 100644
> > --- a/Documentation/devicetree/bindings/rtc/abracon,abx80x.yaml
> > +++ b/Documentation/devicetree/bindings/rtc/abracon,abx80x.yaml
> > @@ -4,7 +4,7 @@
> >  $id: http://devicetree.org/schemas/rtc/abracon,abx80x.yaml#
> >  $schema: http://devicetree.org/meta-schemas/core.yaml#
> >  
> > -title: Abracon ABX80X I2C ultra low power RTC/Alarm chip
> > +title: Abracon ABX80X (I2C) and ABX81X (SPI) ultra low power RTC/Alarm chips
> >  
> >  maintainers:
> >    - linux-rtc@vger.kernel.org
> > @@ -21,10 +21,12 @@ properties:
> >        - abracon,ab0803
> >        - abracon,ab0804
> >        - abracon,ab0805
> > +      - abracon,ab0815
> >        - abracon,ab1801
> >        - abracon,ab1803
> >        - abracon,ab1804
> >        - abracon,ab1805
> > +      - abracon,ab1815
> >        - microcrystal,rv1805
> 
> No ref to spi-peripheral-properties.yaml? Do you not need any spi
> properties, e.g. spi-max-frequency?
> 
Ah yes, missed this... Will add in v2.

> >  
> >    reg:
> > @@ -96,3 +98,14 @@ examples:
> >              interrupts = <44 IRQ_TYPE_EDGE_FALLING>;
> >          };
> >      };
> > +
> > +  - |
> > +    spi {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        rtc@0 {
> > +            compatible = "abracon,ab1815";
> > +            reg = <0>;
> > +        };
> > +    };
> > -- 
> > 2.55.0
> > 


