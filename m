Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798904;
	b=tm7U9bILChH8u1PIpq7t2yZEBnT4VMwf0GoetayvPtDb+A/m4YE8K+dn9K/vwBN2uI+P
	 howVlCL6Oxtxu/cHUTBWX6ZS4w9PHPPJX82R3e5Vnybpzv/v9i5gangUtUn/zro8DunrR
	 NHqQsl2v+PUUMSS9OVGG2rZYmk8TRQ8DdAUYZUOF9hNqSGTftWE150nxQ6s4LS5ViDop4
	 ugdwYMnyu4loM3z91XVrRvFiU2GrIusdKktKaf2mRt7oq7rjqqWLEpiFcb6SeLyB8JvJl
	 lLCISLsB166OG78tydepmYntGTBPCtHLu6UcJ42TJoWFNcZr2WgRq8TMojtx2tYZiLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798904;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=EGUm1WARozo+i2X1STejQqT6PhwjcryBll7NJyIlqmk=;
	b=Lpq8Qnj2sWXboimW7KOnRg80Yx18IWEIzyfYMgZ7SzhZZ2EvcQnviB5371UMsH1D9Kos
	 EaUpOYTtMD10o6El+si64PFEqOqPOwD7vepChwjHe7CJyjdndUYMpuFNg93PoxCQCJeeN
	 BayhYDWp7XgPCkN8D5hlBZMk04y0/o+9nMGL8X37APbi5h9BqrXUkMpZETtjLJz7RKQro
	 TFcVd9WCdzIPrpxF2ZmYUlLxtnV29dldOiaZKSvs6+egut7Oau2RN2RidCCZkbB9MuZD8
	 e3Bzl+FBu5ogkTCySUuQ+aJHXcSoRiZD8Pp1OpHIxPUjMRSoE6TsWR0jJlcygeTpJyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hTf850uv;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4444E606A31E
	for <linux-rtc@vger.kernel.org>; Fri, 27 Nov 2026 17:01:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4444E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hTf850uv
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-491846221ffso7344856f8f.3
        for <linux-rtc@vger.kernel.org>; Fri, 27 Nov 2026 09:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795798902; x=1796403702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EGUm1WARozo+i2X1STejQqT6PhwjcryBll7NJyIlqmk=;
        b=hTf850uvrjJbgZ6iJ/69YwJSmu8EtRtoHJcKFmM4cCRRUC33GwLuUB/cnLsIAwYn9n
         PXADskx87Ee5EDDMcjHGUVDoNm6Wnnw5Ke6YZfsRoZEyqRFbnwWv/P5Znn9TZuJNdcH7
         iJrInWT9qkTAg/lfEDdTHy/+CSp/GHpgZ9/+AdeaiudqtUFlMgM+i25yWIhCZIhq7abZ
         rJ0ZJoBnEsQjH9SE7pb9Po6n2FK1huLCBZuJP4LavJzl5LHdL/rkXcyplTL+4uts48wk
         rKLS8+o57VVc6Mec38BebgVEOtcp6XWa/UnGU2flaexyhtZzuYjDBbZStIpNPqq41r4D
         9DKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795798902; x=1796403702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EGUm1WARozo+i2X1STejQqT6PhwjcryBll7NJyIlqmk=;
        b=K1yn0g2wvRIJn1K95FvMLTuKBPoVpAMFBpunX1kdapzj3ckmPD/jlMjdaRe/Iq63mJ
         aADb0JLZKvocYwlGG8SpOlzkLsMDOhfNfnPwP2W8nAAVEL3URVshuqTRXIq2l/IvrfYH
         lWxFz8KRDiFuLkkhG3ghFJW5CeaTLi41WjQoIlz8pmx4zk6ioZLuWn3ui+947lpxve3i
         KN0ej0LjzlDaF6T0wqSTWM4RzlsNIlFT+VWLF2uIhfkQ5alxt5yxAMcyEuoQkWSBP55g
         xxIDgBRpK+MgLx1PCxilBbYvZkwPnGX9QAKgWNAfGdOU3T5deWgE/Au3xj6FA0xLge/M
         m6kw==
X-Forwarded-Encrypted: i=1; AL+hErHOeVH59ZgNhYnTVLE6apkfi1kw6qHuPV7UWr7mqmavMYVs5ThDbCHzyvEW+THOwKJlknHAaKBUDGQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9lQjpqz5MPWUBOQRI6I+ymBLasUr3xpuLzgNzreLKgtNb+lSKl
	7EMozwWb7neRYu8WKFAutB/7edf/ZGZHB/ToN2WOswGWvfL2o4u8hb+M
X-Gm-Gg: AZFdTZeN9dSsWBfbs4uBGvSadjZynHmnbihu2HJE+2jofRsfmFcf0SSIRRqgPUBkhti
	l59OQnqnr3+QFMvdqzClE2c3fzf4KknPQuM3SNceIG0iO+cCHtINGe5cKAQMKJv/trRPpE4yNDI
	VPYTdoJ094OHEy/suGgwb8f/l+x+789HHk+sGV/OBN5xOhXlvZOQMQlOtlUQYd9p3ytq46PhDlh
	yS35zr7TATZMOtIjf7bchA8V7/juT9O1CGbIsVd5ExfacwaYjiqqcsChgP2CbKogRo3VPKbmuRO
	nrFRH43TVFFZK1M1tIGKxgqz929XEu0q+6KAS+DBRqBSOG4SqshLSOP2OzMspUGkHK1FrcdNAjv
	Q6OekXVJ7IYLfJ0kfMCZlP9N9dU/8cMa1+bi4fnqH1AzZW2rC/IFa/lyrScY4+vXV5semgkNF/V
	O+U/rNrlG1KYGCpkQPLSIDf4WQ5pPjRLJljsgKdjFWKi17H0M+Y/900VRNLi35dDL4n5XOQ3JeJ
	b9uo+Ak3COwHGPVotlPvs/EnVyL1r3l9ednvT/4TzG93Q5b3qyqP5EkVPypE1RvuiZZc7cUA6Ok
	ebO6cUsNxWdOalgCHb7ysgfOe1vLzzicCn2ieoYMZsrdSptmX2pr0o3X34feYz3qXh8D9hSajw2
	W4YVIonKTqlnMa+QqZuNtqPvo+wsJaV948wZIoVNCJS6lfjWhBkI5LdrIXJwiKNmJ3mGeknQhwV
	k=
X-Received: by 2002:a05:600c:6749:b0:4bb:5f95:c014 with SMTP id 5b1f17b1804b1-4bb8880f283mr510208915e9.19.1795798902154;
        Fri, 27 Nov 2026 09:01:42 -0800 (PST)
Received: from othello.home (103.153.90.146.dyn.plus.net. [146.90.153.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906640a2sm407300475e9.0.2026.11.27.09.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 09:01:41 -0800 (PST)
From: Cassio Neri <cassio.neri@gmail.com>
To: thomas.weissschuh@linutronix.de
Cc: jstultz@google.com,
	tglx@kernel.org,
	sboyd@kernel.org,
	mlichvar@redhat.com,
	alexandre.belloni@bootlin.com,
	linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	cassio.neri@gmail.com
Subject: Re: [PATCH v2 4/4] rtc: test: Remove test_rtc_lib.c
Date: Fri, 27 Nov 2026 17:01:52 +0000
Message-ID: <20261127170152.41109-1-cassio.neri@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260903-time-time64-to-tm-v1-4-660be972adfc@linutronix.de>
References: <20260903-time-time64-to-tm-v1-4-660be972adfc@linutronix.de>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These changes look excellent to me.
