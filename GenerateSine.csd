<CsoundSynthesizer>
<CsOptions>
-n
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 256
nchnls = 2
0dbfs = 1

#include "AudioToPolar.csp/AudioToPolar.udo"

opcode Sine, a, kk

  kAmplitude, kFrequency xin

  giSine = ftgen(0, 0, 2^10, 10, 1)

  aOut oscil kAmplitude, kFrequency, giSine

  xout aOut

endop

ga1 init 0

instr 1

kLine line $START_HZ, p3, $END_HZ
ga1 Sine 0.6, kLine

endin

instr 2

ifftsize = 1024
ihopsize = 256
kframe, kmagnitudes[], kfrequencies[] AudioToPolar ga1, ifftsize, ihopsize
hdf5write "$FILE_PATH", kmagnitudes, kfrequencies, ifftsize, ihopsize
ga1 = 0

event("e", 0, $LENGTH)

endin

schedule(1, 0, $LENGTH)
schedule(2, 0, $LENGTH)


</CsInstruments>
<CsScore>
</CsScore>
</CsoundSynthesizer>
